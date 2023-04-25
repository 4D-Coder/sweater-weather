require "rails_helper"

RSpec.describe "Activities API", :vcr do 
  describe "when successful" do 
    before(:each) do 
      get "/api/v0/activities?destination=chicago,il"
      @response = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns the forecast and two activities suitable for it" do
      require 'pry'; binding.pry
      expect(@response.status).to eq(200)
      expect(@response[:data]).to be_a Hash
      expect(@response[:data]).to have_key(:attributes)
      expect(@response[:data][:attributes]).to be_a Hash
    end
  end
end