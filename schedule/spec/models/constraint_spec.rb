require 'rspec'
require_relative '../../models/constraint'
require_relative '../../models/trainer'

describe Constraint do

  it "has a valid factory" do
    
  end

  it "is valid with a training_type, max_participants, start_date, end_date, start_time, end_time, duration, and trainer_id" do
    constraint = build(:constraint)
    expect(constraint).to be_valid
  end

  it "is invalid without a training_type" do
    constraint = build(:constraint, training_type: nil)
    constraint.valid?
    expect(constraint.errors[:training_type]).to include("can't be blank")
  end

  it "is invalid without a max_participants" do
    constraint = build(:constraint, max_participants: nil)
    constraint.valid?
    expect(constraint.errors[:max_participants]).to include("can't be blank")
  end

  it "is invalid without a start_date" do
    constraint = build(:constraint, start_date: nil)
    constraint.valid?
    expect(constraint.errors[:start_date]).to include("can't be blank")
  end

  it "is invalid without a start_time" do
    constraint = build(:constraint, start_time: nil)
    constraint.valid?
    expect(constraint.errors[:start_time]).to include("can't be blank")
  end

  it "is invalid without a end_date" do
    constraint = build(:constraint, end_date: nil)
    constraint.valid?
    expect(constraint.errors[:end_date]).to include("can't be blank")
  end

  it "is invalid without a end_time" do
    constraint = build(:constraint, end_time: nil)
    constraint.valid?
    expect(constraint.errors[:end_time]).to include("can't be blank")
  end

  it "is invalid without a duration" do
    constraint = build(:constraint, duration: nil)
    constraint.valid?
    expect(constraint.errors[:duration]).to include("can't be blank")
  end

  it "is invalid without a trainer"  do
    constraint = build(:constraint, trainer_id: nil)
    constraint.valid?
    expect(constraint.errors[:trainer]).to include("can't be blank")
  end

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
