FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password "12341234"
    password_confirmation "12341234"
    role_type "patient"
  end

  factory :admin, parent: :user do
    email
    role_type "Admin"
  end
end