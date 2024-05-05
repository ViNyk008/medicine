class CreatePatientMedicationMappings < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_medication_mappings,id: :string, force: :cascade do |t|
      t.string :patient_id
      t.string :doctor_id
      t.string :medication_id
      t.text :prescription_data, default: '[]'
      t.timestamps
    end
  end
end
