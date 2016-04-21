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

  describe "filter appointments by date and/or time" do
    let(:private1) {create(:private_lesson_constraint)}
    let(:private2) {create(:private_lesson_constraint)}
    let(:group1) {create(:group_lesson_constraint)}

    context ".date_overlap" do
      it "returns all Group Lesson constraints" do
        expect(Constraint.group_lesson).to eq [group1]
      end
    end

    context ".time_exact" do
      it "returns all Private Lesson constraints" do
        expect(Constraint.private_lesson).to eq [private1, private2]
      end
    end

    context ".time_exact_or_overlap" do
      it "returns all Private Lesson constraints" do
        expect(Constraint.private_lesson).to eq [private1, private2]
      end
    end
  end

end