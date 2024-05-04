class MedicineConfigurationController < ApplicationController
    def medicine_configuration
        patient_id = params["parent_id"]
        doctor_id = params["doctor_id"]
        medicine_frequency = params["medicine_frequency"]
        prescription_data = params["prescription_data"]

        mapping_params = {
        patient_id: patient_id,
        doctor_id: doctor_id,
        medicine_frequency: medicine_frequency,
        prescription_data: prescription_data
        }
        mapping = PatientMedicineMapping.create!(mapping_params)
        
    end
    
end
