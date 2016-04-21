FactoryGirl.define do
  factory :appointment do
    sequence(:request_id) {|n| n}
    training_type 'Private Lesson'
    start_date '2016-01-04'
    end_date '2016-04-01'
    start_time '12:00:00 EST'
    end_time '13:00:00 EST'
    association :student
    association :trainer

    factory :private_appointment do
      training_type 'Private Lesson'
    end

    factory :group_appointment do
      training_type 'Group Lesson'
    end
  end
end