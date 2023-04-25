require "rails_helper"

RSpec.describe ActivitiesFacade do 
  describe ".instance methods", :vcr do 
    describe  "#get_activities" do 
      before(:each) do 
        @activities = ActivitiesFacade.new.get_activities("chicago")
      end

      it "returns the value of a PORO containing forecast and suitable activities for it" do
        expect(@activities).to be_a Activities
        expect(@activities.destination).to eq("chicago")
        
      end
    end
  end
end