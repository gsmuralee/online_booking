FactoryGirl.define do
  factory :table do
    name Faker::Team.name
    code Faker::Lorem.characters(8)
  end
end
