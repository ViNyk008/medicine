class Reminder < ApplicationRecord
    require 'tzinfo'
    require 'sidekiq/cron/job'
    attribute :is_scheduled, :boolean
    attribute :is_sent, :boolean
    attribute :reminder_time ,:datetime


    before_create :set_id
    after_commit :schedule_reminder

    private
    def set_id
        self.id = SecureRandom.hex(16)
    end

    # time_per_day will come in UTC all the time from frontend

    def schedule_reminder
        prescription = Prescription.where(id: self.prescription_id).first
        med_name = prescription.medication.name
        patient = prescription.patient
        email = patient.email
        patient_country_code = patient.country_code
        doctor_name = prescription.doctor.name
        cron = get_cron()
        
        job_name = "medication_reminder_#{self.id}_#{self.reminder_time}"
        binding.pry
        job = Sidekiq::Cron::Job.new(
                    name: job_name,
                    cron: cron,
                    class: MedicationReminderWorker,
                    args: [email, med_name.to_s,prescription.dosage, doctor_name]
            )
    end

    def get_cron
        offset = Prescription.where(id: self.prescription_id).first.patient.get_offset_from_country_code
        utc_time = DateTime.parse(self.reminder_time.to_s)
        offset_hours, offset_minutes = offset[1..].split(':').map(&:to_i)
        offset_hours *= -1 if offset[0] == '-'  # Adjust for negative offsets
        local_time = utc_time.new_offset(Rational(offset_hours, 24) + Rational(offset_minutes, 24*60))
        cron_minute = local_time.min
        cron_hour = local_time.hour
        cron_day_of_month = local_time.day
        cron_month = local_time.month
        cron_day_of_week = local_time.strftime("%u")
        #15 mins before schedule
        cron_minute -= 15  
        #negative case handled
        if cron_minute < 0
            cron_minute += 60
            cron_hour -= 1
        end

        "#{cron_minute} #{cron_hour} #{cron_day_of_month} #{cron_month} #{cron_day_of_week} *"
    end


    # def convert_reminder_time_local(country_code)
    #     country_zones = TZInfo::Country.get(country_code).zones.first
    #     timezone =  TZInfo::Timezone.get(country_zones.as_json["identifier"])
    #     timezone.utc_to_local(self.reminder_time)
    # end
end
