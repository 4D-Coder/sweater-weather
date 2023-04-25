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
      expect(@activities.id).to be_nil
      expect(@activities.destination).to be_a String

      expect(@activities.forecast).to be_a Hash
      expect(@activities.forecast[:summary]).to be_a String
      expect(@activities.forecast[:temperature]).to be_a String
      
      expect(@activities.activities).to be_a Hash

      @activities.activities.each do |activity|
        expect(activity.first).to be_a String
        expect(activity.second).to be_a Hash
        expect(activity.second[:type]).to be_a String
        expect(activity.second[:participants]).to be_an Integer
        expect(activity.second[:price]).to be_a(Float).or be_an(Integer)
      end      
    end
  end
end