require 'rspec'
require_relative '../../models/trainer'

describe Trainer, type: :model do

  it "has a valid factory" do
    expect(build(:trainer)).to be_valid
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :base_name }

end