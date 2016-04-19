require 'rspec'
require_relative '../../models/student'

describe Student do

  it "is valid with a name and a base_name" do
    student = build(:student)
    student.valid?
    expect(student).to be_valid
  end

  it "is invalid without a name" do
    student = build(:student, name: nil)
    student.valid?
    expect(student.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a base_name" do
    student = create(:student, base_name: nil)
    student.update_attributes(base_name: nil)

    student.valid?
    
    expect(student.errors[:base_name]).to include("can't be blank")
  end

end