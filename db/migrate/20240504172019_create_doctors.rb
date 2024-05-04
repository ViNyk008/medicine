class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors, id: :uuid, default: -> { "public.gen_random_uuid()" }, force: :cascade do |t|
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
