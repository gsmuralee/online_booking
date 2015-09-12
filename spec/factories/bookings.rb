FactoryGirl.define do
  factory :booking do
    association :user, factory: :user
    association :table, factory: :table
    start_time DateTime.now + 15.minutes
    reference_number '5IEWH82K8RE'
    duration 30
  end

end
