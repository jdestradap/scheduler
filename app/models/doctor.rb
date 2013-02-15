class Doctor < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_attributes

  validates :first_name, :last_name, presence: true

  has_many :patients, through: :appointments
  has_many :appointments
  has_many :time_slots
  has_one :user, as: :role
  accepts_nested_attributes_for :user

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def doctor_availability(start_date, start_time, end_time)
    not time_slots.find(:first, conditions: ["(start_date = ? AND end_time > ? AND start_time < ?)", start_date, start_time, end_time]).nil?
  end
end
