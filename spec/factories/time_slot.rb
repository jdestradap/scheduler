FactoryGirl.define do
  factory :time_slot do
    start_date Date.today + 1.month
    start_time Time.now + 1.minute
    end_time Time.now + 2.minute
    schedule_rule {}

  	association :doctor
  end
end