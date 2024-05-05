class CreateMedications < ActiveRecord::Migration[6.1]
  def change
    create_table :medications, id: :string, force: :cascade do |t|
      t.string :name
      t.timestamps
    end
  end
end
