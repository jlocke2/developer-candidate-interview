FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    base_name { Faker::Name.name.convert_to_basename }
  end
end