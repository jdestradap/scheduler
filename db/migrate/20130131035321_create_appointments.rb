class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
    add_index :appointments, :doctor_id
    add_index :appointments, :patient_id
    add_index :appointments, [:doctor_id, :start_date], unique: true
    add_index :appointments, [:patient_id, :start_date], unique: true
  end
end
