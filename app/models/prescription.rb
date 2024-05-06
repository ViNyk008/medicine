class Prescription < ApplicationRecord
    require 'sidekiq/cron/job'

    serialize :days, Array
    serialize :time_per_day, Array

    belongs_to :patient , class_name: :Patient
    belongs_to :medication, class_name: :Medication
    belongs_to :doctor, class_name: :Doctor
    has_many :reminder, class_name: :Reminder

    attribute :dosage, :string
    attribute :frequency, :string
    attribute :start_date, :datetime
    attribute :end_date, :datetime
    attribute :status, :string

    validates :dosage, :frequency, :time_per_day, :start_date, :end_date, presence: true

    before_create :set_id
    after_commit :create_reminder

    private
    def set_id
        self.id = SecureRandom.hex(16)
    end

    def create_reminder
        create_reminder_params = {
            prescription_id: self.id
        }
        
        country_code = self.patient.country_code

        if self.frequency == "daily"
            (self.start_date.to_date..self.end_date.to_date).each do |date|
                self.time_per_day.each do |per_day|
                    reminder_time_utc =  DateTime.parse("#{date.to_date} #{per_day}") 
                    Reminder.create!(create_reminder_params.merge(reminder_time: reminder_time_utc, is_scheduled: false))
                end
                
            end
        end

        if self.frequency == "weekly"
            (self.start_date.to_date..self.end_date.to_date).each do |date|
            next unless self.days.include?(date.wday) # Check if the day is included in the days array only that day will create on reminder
                self.time_per_day.each do |per_day|
                    reminder_time_utc = DateTime.parse("#{date.to_s} #{per_day}")
                    reminder_time_local = reminder_time_utc.utc_to_local(reminder_time_utc)
                    reminder = Reminder.create!(create_reminder_params.merge(reminder_time: reminder_time_local, is_scheduled: false))
                end
            end
        end

        if self.frequency == "monthly"
            (self.start_date.to_date..self.end_date.to_date).each do |date|
            next unless self.days.include?(date.day) # Check if the day is included in the days array
                self.time_per_day.each do |per_day|
                    reminder_time_utc = DateTime.parse("#{date.to_s} #{per_day}")
                    reminder_time_local = reminder_time_utc.utc_to_local(reminder_time_utc)
                    reminder = Reminder.create!(create_reminder_params.merge(reminder_time: reminder_time_local, is_scheduled: false))
                end
            end
        end
    end

    # def convert_reminder_time_local(country_code, reminder_time)
    #     country_zones = TZInfo::Country.get("VN").zones.first
    #     timezone =  TZInfo::Timezone.get(country_zones.as_json["identifier"])
    #     timezone.utc_to_local(reminder_time)
    # end
end
