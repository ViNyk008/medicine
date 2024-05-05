class CreateMedicines < ActiveRecord::Migration[6.1]
  def change
    create_table :medicines, id: :string, force: :cascade do |t|
      t.string :name
      t.timestamps
    end
  end
end
