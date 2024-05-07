class DestroyJobWorker
    include Sidekiq::Worker

    CRON = '0 0 * * *' # Run at midnight UTC
    ARGS = {}
    def perform
        reminders = Reminder.where(is_scheduled: true, status: 'active').where('reminder_date > ?', Time.now)
        reminders.each do |reminder|
            job_name = "medication_reminder_#{reminder.id}_#{reminder.reminder_time}"
            job = Sidekiq::Cron::Job.find(job_name)
            job.destroy if job
            reminder.update!(status: 'inactive')
        end
    end
end