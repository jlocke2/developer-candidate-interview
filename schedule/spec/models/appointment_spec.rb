require 'rspec'
require_relative '../../models/appointment'

describe Appointment, type: :model do

  it "has a valid factory" do
    expect(build(:appointment)).to be_valid
  end

  subject { build(:appointment) }
  it { is_expected.to validate_presence_of :request_id }
  it { is_expected.to validate_presence_of :training_type }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
  it { is_expected.to validate_presence_of :student }
  it { is_expected.to validate_presence_of :trainer }
  it { should belong_to(:student) }
  it { should belong_to(:trainer) }

  describe "validating request meets appointment requirements" do
    let(:trainer) {create(:trainer)}

    it "is invalid if not during trainer availability" do
      create(:constraint, start_date: '2016-02-01', trainer: trainer)
      request = build(:appointment, start_date: '2016-01-02', trainer: trainer)

      request.valid?

      expect(request.errors[:base]).to include("instructor not available")
    end

    it "is invalid if not multiple of trainer constraint duration" do
      create(:constraint, duration: '1 hour', trainer: trainer)
      request = build(:appointment, start_time: '12:00:00 EST', end_time: '12:30:00 EST', trainer: trainer)

      request.valid?

      expect(request.errors[:base]).to include("instructor not available")
    end

    it "is invalid if student already has an appointment during requested time" do
      student = create(:student)
      create(:appointment, student: student)
      request = build(:appointment, student: student)

      request.valid?

      expect(request.errors[:base]).to include("student not available")
    end

    it "is invalid if request conflicts private session for trainer" do
      create(:private_appointment, trainer: trainer)
      request = build(:private_appointment, trainer: trainer)

      request.valid?

      expect(request.errors[:base]).to include("instructor not available")
    end

    it "is invalid if request conflicts with and is not perfect match of group session for trainer" do
      create(:group_appointment, trainer: trainer)
      request = build(:group_appointment, start_time: '12:30:00 EST', end_time: '13:30:00 EST', trainer: trainer)

      request.valid?

      expect(request.errors[:base]).to include("instructor not available")
    end

    it "is valid if request conflicts with and is perfect match of group session for trainer" do
      create(:group_appointment, trainer: trainer)
      request = build(:group_appointment, trainer: trainer)

      expect(request).to be_valid
    end

    it "is invalid if session is at full capacity" do
      create(:group_lesson_constraint, max_participants: 5, trainer: trainer)
      create_list(:group_appointment, 5, trainer: trainer)
      request = build(:group_appointment, trainer: trainer)

      request.valid?

      expect(request.errors[:base]).to include("instructor not available")
    end
  end

  describe "filter appointments by date and/or time" do
    let(:apt1) {create(:appointment, start_time: '12:30:00 EST', end_time: '13:30:00 EST')}
    let(:apt2) {create(:appointment, start_time: '12:30:00 EST', end_time: '13:30:00 EST')}
    let(:apt3) {create(:appointment, start_time: '12:00:00 EST', end_time: '13:00:00 EST')}
    let(:apt4) {create(:appointment, start_date: '2016-06-04', end_date: '2016-08-04')}

    context ".date_overlap" do
      it "returns all Group Lesson constraints" do
        expect(Appointment.date_overlap('2016-07-04','2016-09-04')).to eq [apt4]
      end
    end

    context ".time_exact" do
      it "returns all Private Lesson constraints" do
        expect(Appointment.time_exact('12:30:00 EST','13:30:00 EST')).to eq [apt1, apt2]
      end
    end

    context ".time_exact_or_overlap" do
      it "returns all Private Lesson constraints" do
        expect(Appointment.time_exact_or_overlap('12:30:00 EST','13:30:00 EST')).to eq [apt1, apt2, apt3]
      end
    end
  end

end