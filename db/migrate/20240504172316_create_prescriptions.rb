class CreatePrescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :prescriptions,id: :string, force: :cascade do |t|
      t.string :patient_id
      t.string :doctor_id
      t.string :medication_id
      t.string :dosage
      t.string :frequency
      t.text :days, default: '[]'
      t.text :time_per_day, default: '[]'
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.timestamps
    end
  end
end
