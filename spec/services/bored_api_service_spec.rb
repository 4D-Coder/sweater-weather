require "rails_helper"

RSpec.describe BoredApiService do 
  describe "#instance methods"do 
    describe "#get_activity(type)", :vcr do 
      it "returns an activity based on a given correct type parameter" do
        activity = BoredApiService.new.get_activity("music")

        expect(activity).to be_a(Hash)

        expect(activity).to have_key(:activity)
        expect(activity[:activity]).to be_a String

        expect(activity).to have_key(:type)
        expect(activity[:activity]).to be_a String
        
        expect(activity).to have_key(:participants)
        expect(activity[:participants]).to be_an Integer
        
        expect(activity).to have_key(:link)
        expect(activity[:link]).to be_a String

        expect(activity).to have_key(:key)
        expect(activity[:key]).to be_a String
        
        expect(activity).to have_key(:accessibility)
        expect(activity[:accessibility]).to be_an Integer
      end
    end
  end
end