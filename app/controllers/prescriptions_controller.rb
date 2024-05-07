class PrescriptionsController < ApplicationController
    ## ASSUMPTION: All data coming from frontend is in UTC, and storing all data in UTC format in DB.
    ## For  use cases converting into time zone offset
    # request = {"patient_email":"vivek@gmail.com","doctor_email":"nayak2@example.com",
    # "prescription":{"Medicine A":
    # {"frequency":"daily","days":[],"times_per_day":["08: 00: 00","21: 00: 00"],"dosage":"2tab","start_date":"2024-05-05 21: 00: 00+0000","end_date":"2024-06-05 21: 00: 00+0000"},
    # "Medicine B":{"frequency":"weekly","days":[2,6],"times_per_day":["08: 00: 00"],"dosage":"1tab","start_date":"2024-05-05 21: 00: 00+0000","end_date":"2024-06-05 21: 00: 00+0000"},
    # "Medicine C":{"frequency":"monthly","days":[],"times_per_day":["08: 00: 00"]},"dosage":"1tab","start_date":"2024-05-05 21: 00: 00+0000","end_date":"2024-06-05 21: 00: 00+0000"}}    

    def create(params)
        params = params.as_json
        patient_email = params["patient_email"]
        doctor_email = params["doctor_email"]

        patient_id = find_patient_id_if_exist(patient_email)
        doctor_id = find_doctor_id_if_exist(doctor_email)

        prescriptions = params["prescriptions"]
        prescriptions.each do |medication, details|
            medication_id = find_medication_id_if_exist(medication)
            create_param = {
            patient_id: patient_id,
            doctor_id: doctor_id,
            medication_id: medication_id,
            frequency: details["frequency"],
            days: details["days"],
            time_per_day: details["times_per_day"],
            dosage: details["dosage"],
            start_date: details["start_date"],
            end_date: Time.parse(details["end_date"])}

            prescription = Prescription.new(create_param)

            unless prescription.save!
                self.errors.merge!(prescription.errors)
                return
            end
        end
    end

    def new

    end

    def find_patient_id_if_exist(patient_email)
        patient = Patient.where(email: patient_email, status: 'active').first
        if patient.blank?
            self.errors.add(:no_found, "not found active patient")
            return
        end
        patient.id
    end

    def find_doctor_id_if_exist(doctor_email)
        doctor = Doctor.where(email: doctor_email, status: 'active').first
        if doctor.blank?
            self.errors.add(:no_found, "not found active doctor")
            return
        end
        doctor.id
    end
    def find_medication_id_if_exist(medication_name)
        medication = Medication.where(name: medication_name, status: 'active').first
        if medication.blank?
            self.errors.add(:no_found, "not found active medication")
        end
        medication.id
    end
end

