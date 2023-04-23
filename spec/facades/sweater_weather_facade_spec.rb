require 'rails_helper'

RSpec.describe SweaterWeatherFacade do
  describe '.class_methods' do
    context '#initialize' do 
      let(:sweater_weather) { described_class.new }

      it 'exists' do
        expect(sweater_weather).to be_a(SweaterWeatherFacade)
      end

      it 'has attributes' do 
        expect(sweater_weather.params).to be_a(Hash)
        expect(sweater_weather.mapquest_service).to be_a(MapquestGeoApiService)
        expect(sweater_weather.weather_service).to be_a(WeatherApiService)
      end
    end
  end

  describe '.instance_methods' do
    before do
      @location_params = {"location"=>"denver,co"}
    end

    context 'five_day_forecast' do
      it "can receive a location parameter and return create a forecast objects" do
        VCR.use_cassette('GET_mapquest_coordinates', record: :new_episodes) do
          SweaterWeatherFacade.new(@location_params).five_day_forecast
        end
      end
    end
  end
end