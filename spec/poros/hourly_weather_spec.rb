require 'rails_helper'

RSpec.describe HourlyWeather do
  let(:location_coordinates) {"39.74001,-104.99202"}
  let(:forecast_data) do
    VCR.use_cassette('GET 5_day_forecast', record: :new_episodes ) do
      response = WeatherApiService.new.get_5_day_forecast_by(location_coordinates)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
  let(:midnight_weather_data) { forecast_data[:forecast][:forecastday].first[:hour].first }

  describe '.class_methods' do
    context '#initialize' do
      it 'exists' do
        midnights_weather = HourlyWeather.new(midnight_weather_data)
        expect(midnights_weather).to be_a(HourlyWeather)
      end
    end
  end

  describe '.instance_methods' do
    let(:hourly_weather) { HourlyWeather.new(midnight_weather_data) }

    context '#initialize' do
      it 'has_attributes' do
        expect(hourly_weather.time).to eq(midnight_weather_data[:time])
        expect(hourly_weather.temperature).to eq(midnight_weather_data[:temp_f])
        expect(hourly_weather.condition).to eq(midnight_weather_data[:condition][:text])
        expect(hourly_weather.icon).to eq(midnight_weather_data[:condition][:icon])
      end
    end
  end
end