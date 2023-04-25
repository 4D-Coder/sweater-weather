require "rails_helper"

RSpec.describe Activities do 
  describe "#initialize", :vcr do 
    before(:each) do 
      # Facade method expected to have the same return as the PORO 
      # with proper arguments
      @activities = ActivitiesFacade.new.get_activities("chicago,il")
    end

    it "exists" do
      expect(@activities).to be_a Activities
    end

    it "has attrributes" do
      require 'pry'; binding.pry
    end
  end
end