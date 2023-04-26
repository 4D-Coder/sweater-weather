require 'rails_helper'

RSpec.describe RoadTripFacade do
  let(:road_trip) { described_class.new("missoula, mt", "bozeman, mt") }

  describe '.class_methods' do

    context '#initialize' do

      it 'exists' do
        expect(road_trip).to be_a(RoadTripFacade)
      end

      it 'has attributes' do
        expect(road_trip.origin).to be_a String
        expect(forecast.destination).to be_a String
      end
    end
  end

  describe '.instance_methods' do
    context '#road_trip_summary' do
      it ' it returns the start_city, end_city, travel_time, and weather_at_eta' do
        road_trip_summary = road_trip.road_trip_summary

        expect(road_trip_summary.id).to be_nil
        expect(road_trip_summary.start_city).to be_a String
        expect(road_trip_summary.end_city).to be_a String
        expect(road_trip_summary.travel_time).to be_a String

        expect(road_trip_summary.weather_at_eta).to be_a Hash
      end
    end
  end
end

