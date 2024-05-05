class MedicineConfigurationController < ApplicationController
    def medicine_configuration
        patient_email = params["patient_email"]
        doctor_email = params["doctor_email"]
        prescription_data = params["prescription"]
        # prescription data: 
        # [{medication1: { daily: ["2:00", "20:00"] }, 
        #     medication2: { weekly: [{monday: ["9:00","14:00", "20:00"]}, wednesday: ["9:00", "20:00"]]}}]

        patient_id = find_patient(patient_email)
        doctor_id = find_patient(doctor_email)
        validate_prescription_data
        mapping_params = {
            patient_id: patient_id,
            doctor_id: doctor_id,
            prescription_data: prescription_data
        }
        mapping = PatientMedicationMapping.create!(mapping_params)
        
    end

    def find_patient(patient_email)
        patient = Patient.where(email: patient_email, status: 'active').first
        if patient.blank?
            self.errors.add(:no_found, "not found active patient")
            return
        end
        patient.id
    end

    def find_doctor(doctor_email)
        doctor = Patient.where(email: doctor_email, status: 'active').first
        if patient.blank?
            self.errors.add(:no_found, "not found active doctor")
            return
        end
        doctor.id
    end

    # def validate_prescription_data(prescription)
    #     if prescription.blank?
    #         self.errors.add(:no_data, "no prescription" )
    #         return 
    #     end
        
    #     # prescription data: 
    #     # [{medication1: { daily: ["2:00", "20:00"] }, 
    #     #     medication2: { weekly: [{monday: ["9:00","14:00", "20:00"]}, wednesday: ["9:00", "20:00"]]}}]
    #     prescription.each do |it|
    #     end
    # end
    
end
