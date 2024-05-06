class MedicationReminderWorker
  include Sidekiq::Worker

  def perform(email, medication_name, dosage, doctor_name)
    ReminderMailer.send_reminder(email, medication_name, dosage, doctor_name).deliver_now
  end
end
