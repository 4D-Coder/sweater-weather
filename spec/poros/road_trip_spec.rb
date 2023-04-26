require 'rails_helper'

RSpec.describe RoadTrip do
  let(:trip) { RoadTripFacade.new("Missoula, MT", "Bozeman, MT").road_trip_summary }

  describe '.class_methods', :vcr do
    context '#initialize' do
      it 'exists' do
        expect(trip).to be_a(RoadTrip)
      end
      
      it 'has attributes' do
        expect(trip.start_city).to eq("Missoula, MT")
        expect(trip.end_city).to eq("Bozeman, MT")
        expect(trip.travel_time).to eq("02:51:38")
        expect(trip.weather_at_eta).to be_a Hash
        expect(trip.weather_at_eta[:datetime]).to eq("2023-04-26 11:00")
        expect(trip.weather_at_eta[:temperature]).to eq(51.6)
        expect(trip.weather_at_eta[:condition]).to eq("Sunny")
      end
    end
  end
end
