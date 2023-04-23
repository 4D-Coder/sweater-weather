require 'rails_helper'

RSpec.describe CurrentWeather do
  let(:location_coordinates) {"39.74001,-104.99202"}
  let(:forecast_data) do
    VCR.use_cassette('GET 5_day_forecast', record: :new_episodes ) do
      response = WeatherApiService.new.get_5_day_forecast_by(location_coordinates)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
  let(:current_weather_data) { forecast_data[:current] }

  describe '.class_methods' do
    context '#initialize' do
      it 'exists' do
        current_weather = CurrentWeather.new(current_weather_data)
        expect(current_weather).to be_a(CurrentWeather)
      end
    end
  end

  describe '.instance_methods' do
    let(:current_weather) { CurrentWeather.new(current_weather_data) }

    context '#initialize' do
      it 'has_attributes' do
        expect(current_weather.last_updated).to eq(current_weather_data[:last_updated])
        expect(current_weather.temperature).to eq(current_weather_data[:temp_f])
        expect(current_weather.feels_like).to eq(current_weather_data[:feelslike_f])
        expect(current_weather.humidity).to eq(current_weather_data[:humidity])
        expect(current_weather.uvi).to eq(current_weather_data[:uv])
        expect(current_weather.visibility).to eq(current_weather_data[:vis_miles])
        expect(current_weather.condition).to eq(current_weather_data[:condition][:text])
        expect(current_weather.icon).to eq(current_weather_data[:condition][:icon])
      end
    end
  end
end