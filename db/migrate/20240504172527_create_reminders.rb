class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders,id: :string, force: :cascade do |t|
      t.string :prescription_id
      t.datetime :reminder_time
      t.boolean :is_scheduled
      t.boolean :is_sent
      t.timestamps
    end
  end
end