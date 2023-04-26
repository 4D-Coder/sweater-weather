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
        expect(response.status).to eq(200)

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expected_keys.each do |key, value|
          expect(road_trip).to have_key(key)
          expect(road_trip[key]).to be_a(value.class)
        
          if value.is_a?(Hash)
            value.each do |nested_key, nested_value|
              expect(road_trip[key]).to have_key(nested_key)
              expect(road_trip[key][nested_key]).to be_a(nested_value)
            end
          end
        end
      end
    end
  end
end