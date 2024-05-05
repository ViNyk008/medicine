class PatientMedicationMapping < ApplicationRecord
    require 'sidekiq/cron/job'

    attribute :doctor_id, :uuid
    attribute :patient_id, :uuid
    attribute :prescription_data

    belongs_to :patient
    belongs_to :medication
    
    validate :valid_prescription_data_structure


    after_commit: trigger_schedular

    def valid_prescription_data_structure
        if prescription_data.present?
        unless prescription_data.is_a?(Array) && prescription_data.all? { |prescription| prescription.is_a?(Hash) }
            errors.add(:prescription_data, "must be an array of hashes")
            return
        end
        #validatiing daily prescription should have time array and weekly should have day and time
        prescription_data.each do |prescription|
            prescription.each do |medication, schedule|
            unless schedule.is_a?(Hash) && schedule.all? { |freq, times| freq.in?(%w[daily weekly]) && times.is_a?(Array) && times.all? { |time| time =~ /\A\d{1,2}:\d{2}\z/ } }
                errors.add(:prescription_data, "has invalid structure")
                return
            end

            if schedule['weekly']
                unless schedule['weekly'].is_a?(Array) && schedule['weekly'].all? { |day_schedule| day_schedule.is_a?(Hash) && day_schedule.all? { |day, times| day.to_sym.in?(Date::DAYNAMES.map(&:downcase)) && times.is_a?(Array) && times.all? { |time| time =~ /\A\d{1,2}:\d{2}\z/ } } }
                    errors.add(:prescription_data, "has invalid weekly schedule")
                    return
                end
            end
        end
    end

    def trigger_schedular
        email = Patient.where(self.id).first.email
        job_name = "medication_reminder_#{self.id}"
        job = Sidekiq::Cron::job.new(
                name: job_name,
                cron: get_cron )
                class: MedicationReminderWorker,
                args: [email, med_name.to_s]
    end

    #to Get email sending time from prescription
    def cron_expressions(prescription_data)             
        medication_data.each_with_object([]) do |medication, cron_expressions|
            medication.each do |med_name, schedule|
                schedule.each do |frequency, timings|
                    timings.each do |timing|
                        cron_expression = case frequency
                            when :daily
                              convert_daily_timing_to_cron(timing)
                            when :weekly
                              convert_weekly_timing_to_cron(timing)
                            else
                              nil
                            end
                            cron_expressions << { medication: med_name, cron: cron_expression } if cron_expression
                        end
                    end
                end
            end
    end

    # crons formatting
    def convert_daily_timing_to_cron(time)
        hours, minutes = time.split(':').map(&:to_i)
        "0 #{hours} #{minutes} * * *" 
    end
    def convert_weekly_timing_to_cron(day_time)
        day, time = day_time.first
        hours, minutes = time.split(':').map(&:to_i)
        "0 #{hours} #{minutes} * * #{day.to_s.capitalize}"
    end
end
