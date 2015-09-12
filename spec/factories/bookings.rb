FactoryGirl.define do
  factory :booking do
    association :user, factory: :user
    association :table, factory: :table
    start_time DateTime.now
    duration 10
  end

end
