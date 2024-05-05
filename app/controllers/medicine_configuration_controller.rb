class MedicineConfigurationController < ApplicationController
    def medicine_configuration(params)
        params = params.as_json
        patient_email = params["patient_email"]
        doctor_email = params["doctor_email"]
        prescription_data = params["prescription_data"]
        # prescription data: 
        # [{medication1: { daily: ["2:00", "20:00"] }, 
        #     medication2: { weekly: [{monday: ["9:00","14:00", "20:00"]}, wednesday: ["9:00", "20:00"]]}}]

        initialise()

        patient_id = find_patient(patient_email)
        doctor_id = find_doctor(doctor_email)


        mapping_params = {
            patient_id: patient_id,
            doctor_id: doctor_id,
            prescription_data: prescription_data
        }
        mapping = PatientMedicationMapping.create!(mapping_params)
        
    end

    #just to intialize db value for testing purpose
    def initialise
        Patient.create!(name: "vivek", email:"vgarg7900@gmail.com",country_code: "IN")
        Doctor.create!(name: "Nayak", email:"vivek.garg@cogoport.com")
        Medication.create!(name: "medication1")
        Medication.create!(name: "medication2")
    end

    def find_patient(patient_email)
        patient = Patient.where(email: patient_email).first
        if patient.blank?
            self.errors.add(:no_found, "not found active patient")
            return
        end
        patient.id
    end

    def find_doctor(doctor_email)
        doctor = Doctor.where(email: doctor_email).first
        if doctor.blank?
            self.errors.add(:no_found, "not found active doctor")
            return
        end
        doctor.id
    end
end

