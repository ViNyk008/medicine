class PatientMedicineMapping < ApplicationRecord
    require 'sidekiq/cron/job'
    FREQUENCY = [daily weekly monthly]
    attribute :medicine_frequency, :string
    attribute :doctor_id, :uuid
    attribute :patient_id, :uuid
    attribute :prescription_data, PrescriptionData.to_array_type, required: true

    validates :medicine_frequency.includes?(FREQUENCY)

    after_commit: trigger_schedular

    def trigger_schedular
        job_name = "Reminder #{self.id}"
        job = Sidekiq::Cron::job.new(
                name: job_name,
                cron: get_cron )
                klass: "",
                args: self.id
    end
    def get_cron
        frequency = self.medicine_frequency
        time = self.prescription_data.time
        day = self.prescription_data.day
        date = self.prescription_data.date
        cron_details = {}
        case frequency
        when "daily"
            cron_details = {cron: ""}
        when "weekly"
            cron_details = {cron: ""}
        when "monthly"
            cron_details = {cron: ""}
        else
        end
    end
end
