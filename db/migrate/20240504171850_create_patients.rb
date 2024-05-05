class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients, id: :string, force: :cascade  do |t|
      t.string :name
      t.string :email
      t.string :country_code
      t.timestamps
    end
  end
end