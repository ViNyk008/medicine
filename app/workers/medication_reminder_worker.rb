class MedicationReminderWorker
  include Sidekiq::Worker

  def perform(email, medication_name)
    patient = Patient.find_by(email: email)
    if patient
      medication = patient.medications.find_by(name: medication_name)
      if medication
        # Send reminder email
        ReminderMailer.send_reminder(email, medication_name).deliver_now
      else
        puts "Medication not found for patient with email #{email} and name #{medication_name}"
      end
    else
      puts "Patient not found with email #{email}"
    end
  end
end
