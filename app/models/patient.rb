class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :doctors, through: :appointments
  belongs_to :user
end
