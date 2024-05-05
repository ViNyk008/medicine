class CreatePatientMedicationMappings < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_medication_mapping,id: :string, force: :cascade do |t|
      t.string :patient_id
      t.string :doctor_id
      t.string :medicine_id
      t.text :prescription_data, default: '[]'
      t.timestamps
    end
  end
end
