FactoryGirl.define do
  factory :appointment do
    start_date DateTime.now + 1.year
  	association :doctor
  	association :patient
  end
end