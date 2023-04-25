require "rails_helper"

RSpec.describe ActivitiesFacade do 
  describe ".instance methods", :vcr do 
    describe  "#get_activities" do 
      before(:each) do 
        @param = "chicago,il"
        @activities = ActivitiesFacade.new.get_activities(@param)
      end

      it "returns the value of a PORO containing forecast and suitable activities for it" do
        expect(@activities).to be_a Activities
        expect(@activities.id).to be_nil
        expect(@activities.destination).to eq(@param)
        expect(@activities.activities).to be_a Hash

        expect(@activities.activities.first[1][:type]).to eq("relaxation")

        expect(@activities.forecast).to be_a Hash
        expect(@activities.forecast).to have_key(:temperature)

        expect(@activities.forecast[:temperature]).to include("F")
      end
    end
  end
end