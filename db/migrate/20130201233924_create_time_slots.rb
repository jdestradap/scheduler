class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :doctor_id
      t.date :start_date
      t.time :start_time
      t.time :end_time
      t.string :schedule_rule
      t.boolean :recurrent, default: false

      t.timestamp
    end
  end
end