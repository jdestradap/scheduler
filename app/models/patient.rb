class Patient < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_attributes

  validates :first_name, :last_name, presence: true

  has_many :appointments
  has_many :doctors, through: :appointments
  has_one :user, as: :role

  accepts_nested_attributes_for :user

  def full_name
    "#{first_name} #{last_name}".strip
  end
end