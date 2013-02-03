class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :doctor_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamp
    end
  end
end