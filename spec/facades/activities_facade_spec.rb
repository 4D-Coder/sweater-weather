require "rails_helper"

RSpec.describe ActivitiesFacade do 
  describe ".instance methods", :vcr do 
    describe  "#get_activities" do 
      before(:each) do 
        @activities = ActivitiesFacade.new.get_activities("chicago")
      end

      it "returns the value of a PORO containing forecast and suitable activities for it" do
        
      end
    end
  end
end