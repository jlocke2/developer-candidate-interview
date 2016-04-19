require 'rspec'
require_relative '../../models/trainer'

describe Trainer do

  it "is valid with a name and a base_name" do
    trainer = build(:trainer)
    trainer.valid?
    expect(trainer).to be_valid
  end

  it "is invalid without a name" do
    trainer = build(:trainer, name: nil)
    trainer.valid?
    expect(trainer.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a base_name" do
    trainer = create(:trainer, base_name: nil)
    trainer.update_attributes(base_name: nil)

    trainer.valid?
    
    expect(trainer.errors[:base_name]).to include("can't be blank")
  end

end