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
    context 'retrieve_weather(city)' do
      it 'can'
    end
  end
end