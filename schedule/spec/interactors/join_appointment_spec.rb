require 'rspec'
require_relative '../../interactors/join_appointment'

describe JoinAppointment do
  subject(:context) { JoinAppointment.call(attributes_for(:appointment_request)) }

  describe ".call" do
    context "when given valid credentials" do
      let(:appointment) { double(save: true) }

      before do
        allow(Appointment).to receive(:new).and_return(appointment)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the appointment" do
        expect(context.appointment).to eq(appointment)
      end

    end

    context "when given invalid credentials" do
      let(:appointment) { double(save: false) }

      before do
        allow(Appointment).to receive(:new).and_return(appointment)
      end

      it "fails" do
        expect(context).to be_a_failure
      end

      it "provides the appointment" do
        expect(context.appointment).to eq(appointment)
      end

    end
  end
end