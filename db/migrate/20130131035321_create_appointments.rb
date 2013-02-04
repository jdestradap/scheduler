class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.datetime :start_date
      t.timestamps
    end
    add_index :appointments, :doctor_id
    add_index :appointments, :patient_id
    add_index :appointments, [:doctor_id, :patient_id], unique: true
  end
end
