require 'rails_helper'

RSpec.describe 'RoadTrip API' do
  describe 'roadtrip show' do
    let(:user) { create(:user) }
    
    context 'When successful' do
      let(:request_body) do
        {
          origin: "Cincinatti,OH",
          destination: "Chicago,IL",
          api_key: user.api_key
        }
      end
      let(:expected_keys) do
      {
        data: {
          id: nil,
          type: "road_trip",
          attributes: {
            start_city: String,
            end_city: String,
            travel_time: String,
            weather_at_eta: {
              datetime: String,
              temperature: Float,
              condition: String
            }
          }
        }
      }
      end
      let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

      it 'can create a roadtrip' do
        post('/api/v0/road_trip', params: request_body.to_json, headers: headers)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip[:data]).to be_a Hash
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to be_nil

        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to be_a String
        
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:attributes]).to be_a Hash
        
        attributes = road_trip[:data][:attributes]

        expect(attributes).to have_key(:start_city)
        expect(attributes[:start_city]).to be_a String
        
        expect(attributes).to have_key(:end_city)
        expect(attributes[:start_city]).to be_a String

        expect(attributes).to have_key(:start_city)
        expect(attributes[:start_city]).to be_a String
        

        
        require 'pry'; binding.pry
      end
    end
  end
end