class Doctor < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_attributes

  validates :first_name, :last_name, presence: true

  has_many :patients, through: :appointments
  has_many :time_slots
  has_one :user, as: :role
  accepts_nested_attributes_for :user
end
