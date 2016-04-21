require 'rspec'
require_relative '../../controllers/appointments_controller'

describe AppointmentsController do

  it "returns an error string if wrong file type" do
    file = "something.pdf"

    expect(ConstraintsController.new.create(file)).to be_a(String)
  end

end