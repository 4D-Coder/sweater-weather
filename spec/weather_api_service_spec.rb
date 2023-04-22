require 'rails_helper'

RSpec.describe WeatherApiService do
  describe 'instance methods' do
    context 'get_forecast_by(city)' do
      before do
        VCR.use_cassette('mapquest_geo_api_service_spec.rb', record: :once) do
          response = MapquestGeoApiService.new.get_coordinates("Denver", "CO")
          json = JSON.parse(response.body, symbolize_names: true)

          @lat = json[:results].first[:locations].first[:latLng][:lat]
          @lng = json[:results].first[:locations].first[:latLng][:lng]
        end
      end
      it 'can retreive weather for a city' do
        VCR.use_cassette('weather_api_service_spec.rb', record: :once) do
          response = WeatherApiService.new.get_forecast_by(@lat, @lng)
          json = JSON.parse(response.body, symbolize_names: true)
          require 'pry'; binding.pry
        end


      end
    end
  end
end