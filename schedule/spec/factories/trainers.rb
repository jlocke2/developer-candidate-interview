FactoryGirl.define do
  factory :trainer do
    name { Faker::Name.name }
    base_name { Faker::Name.name.convert_to_basename }
  end
end