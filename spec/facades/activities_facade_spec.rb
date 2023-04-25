require "rails_helper"

RSpec.describe ActivitiesFacade do 
  describe ".instance methods", :vcr do 
    describe  "#get_activities" do 
      before(:each) do 
        @activities = ActivitiesFacade.new.get_activities("chicago,il")
      end

      it "returns the value of a PORO containing forecast and suitable activities for it" do
        expect(@activities).to be_a Activities
        expect(@activities.id).to be_nil
        expect(@activities.destination).to eq("chicago,il")
        expect(@activities.activities).to be_a Hash
     
        expect(@activities.forecast).to be_a Hash
        expect(@activities.forecast).to have_key(:temperature)

        expect(@activities.forecast[:temperature]).to include("F")
      end
    end
  end
end