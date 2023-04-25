require "rails_helper"

RSpec.describe "Activities API", :vcr do 
  describe "when successful" do 
    before(:each) do 
      get "/api/v0/activities?destination=chicago,il"
    end
    
    it "returns the forecast and two activities suitable for it" do
      expect(response.status).to eq(200)
      
      @response = JSON.parse(response.body, symbolize_names: true)

      expect(@response).to have_key(:data)
      expect(@response[:data]).to be_a Hash

      expect(@response[:data]).to have_key(:attributes)
      expect(@response[:data][:attributes]).to be_a Hash

      attributes = @response[:data][:attributes]

      expect(attributes[:destination]).to be_a String
      expect(attributes[:forecast]).to be_a Hash
      expect(attributes[:forecast][:summary]).to be_a String
      expect(attributes[:forecast][:temperature]).to be_a String
      expect(attributes[:activities]).to be_a Hash
      
      attributes[:activities].each do |k, v|
        expect(k.to_s).to be_a String
        expect(v).to be_a Hash
        expect(v[:type]).to be_a String
        expect(v[:participants]).to be_an Integer
        expect(v[:price]).to be_an(Integer).or be_a(Float)
      end
    end
  end
end