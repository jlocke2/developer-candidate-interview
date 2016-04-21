FactoryGirl.define do
  factory :appointment_request, class: OpenStruct do
    sequence(:request_id) {|n| n}
    name 'Johnny Schmoe'
    training_type 'Private Lesson'
    start_date '2016-01-04'
    end_date '2016-04-01'
    start_time '12:00:00 EST'
    end_time '17:00:00 EST'
    with 'Joe Schmoe'
  end
end