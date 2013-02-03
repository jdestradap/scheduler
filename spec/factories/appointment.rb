FactoryGirl.define do
  factory :appointment do
    start_date DateTime.new(2013,02,03,10,30,00,'-5')
  	association :doctor
  	association :patient
  end
end