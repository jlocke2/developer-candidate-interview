require 'rspec'
require_relative '../lib/extend_string'

describe String do

  describe "#convert_to_basename" do
    context "passed 'Something To Do' " do
      it "returns 'something_to_do' " do
        expect('Something To Do'.convert_to_basename).to eq 'something_to_do'
      end
    end

    context "passed '  $!Hi T455here!  ' " do
      it "returns 'hi_there' " do
        expect('  $!Hi T455here!  '.convert_to_basename).to eq 'hi_there'
      end
    end

    context "passed 'already_formatted'" do
      it "returns 'already_formatted' " do
        expect('already_formatted'.convert_to_basename).to eq 'already_formatted'
      end
    end
  end

end