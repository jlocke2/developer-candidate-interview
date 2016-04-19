FactoryGirl.define do
  factory :constraint do
    training_type 'Private Lesson'
    max_participants { Faker::Number.between(1, 10) }
    start_date '2016-01-04'
    end_date '2016-04-01'
    start_time '12:00:00 EST'
    end_time '17:00:00 EST'
    duration '1 hour'
    association :trainer

    factory :private_lesson_constraint do
      training_type 'Private Lesson'
    end

    factory :group_lesson_constraint do
      training_type 'Group Lesson'
    end
  end
end