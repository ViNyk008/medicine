class CreateMedications < ActiveRecord::Migration[6.1]
  def change
    create_table :medications, id: :string, force: :cascade do |t|
      t.string :name
      t.integer :serial_id
      t.string :description
      t.string :status
      t.timestamps
    end
  end
end
