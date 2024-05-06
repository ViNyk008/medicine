class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors, id: :string, force: :cascade do |t|
      t.string :name
      t.string :email
      t.string :specialization
      t.string :phone_number
      t.string :status
      t.timestamps
    end
  end
end
