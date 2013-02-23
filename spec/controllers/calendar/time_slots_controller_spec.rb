require "spec_helper"

describe Calendar::TimeSlotsController do
  before { controller.stub(authenticate_doctor!: true) }

  describe "POST 'create'" do
    let(:time_slot) { double.as_null_object }
    before { TimeSlot.stub(new: time_slot) }

    context "when user gets saved" do
      before { time_slot.stub(save: true, doctor_id: 1) }

      it "redirects to the calendar_time_slots_path" do
        expect(time_slot.save).to be_true
        post 'create'
        response.should redirect_to calendar_time_slots_path(doctor_id: "1")
      end
    end
  end
end