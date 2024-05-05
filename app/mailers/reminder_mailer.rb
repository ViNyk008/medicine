class ReminderMailer < ApplicationMailer
    def send_reminder(email, medication_name)
        mail(to: email, subject: "Medication Reminder #{medication_name}")
    end
end