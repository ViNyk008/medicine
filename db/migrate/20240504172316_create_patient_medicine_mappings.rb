class CreatePatientMedicineMappings < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_medicine_mappings, id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
      t.uuid :patient_id
      t.uuid :doctor_id
      t.uuid :medicine_id
      t.uuid :prescription_data
      t.timestamps
    end
  end
end
