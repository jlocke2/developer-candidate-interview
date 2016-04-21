require 'rspec'
require_relative '../../models/constraint'
require_relative '../../models/trainer'

describe Constraint, type: :model do

  it "has a valid factory" do
    expect(build(:constraint)).to be_valid
  end

  it { is_expected.to validate_presence_of :training_type }
  it { is_expected.to validate_presence_of :max_participants }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :end_time }
  it { is_expected.to validate_presence_of :duration }
  it { is_expected.to validate_presence_of :trainer }
  it { should belong_to(:trainer) }

  describe "filter constraints by training_type" do
    let(:private1) {create(:private_lesson_constraint)}
    let(:private2) {create(:private_lesson_constraint)}
    let(:group1) {create(:group_lesson_constraint)}

    context ".group_lesson" do
      it "returns all Group Lesson constraints" do
        expect(Constraint.group_lesson).to eq [group1]
      end
    end

    context ".private_lesson" do
      it "returns all Private Lesson constraints" do
        expect(Constraint.private_lesson).to eq [private1, private2]
      end
    end
  end

end
