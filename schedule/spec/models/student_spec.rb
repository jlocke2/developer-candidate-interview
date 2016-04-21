require 'rspec'
require_relative '../../models/student'

describe Student, type: :model do

  it "has a valid factory" do
    expect(build(:student)).to be_valid
  end

  it {is_expected.to validate_presence_of :name}
  it {is_expected.to validate_presence_of :base_name}

end