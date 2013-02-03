FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password "12341234"
    password_confirmation "12341234"
    role_type "Patient"
  end

  factory :admin_user, parent: :user do
    email
    role_type "Admin"
  end

  factory :doctor_user, parent: :user do
    email
    role_type "Doctor"
  end
end