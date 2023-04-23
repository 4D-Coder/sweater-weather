require 'rails_helper'

RSpec.describe DailyWeather do
  let(:location_coordinates) {"39.74001,-104.99202"}
  let(:forecast_data) do
    VCR.use_cassette('GET 5_day_forecast', record: :new_episodes ) do
      response = WeatherApiService.new.get_5_day_forecast_by(location_coordinates)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
  let(:todays_weather_data) { forecast_data[:forecast][:forecastday].first }

  describe '.class_methods' do
    context '#initialize' do
      it 'exists' do
        todays_weather = DailyWeather.new(todays_weather_data)
        expect(todays_weather).to be_a(DailyWeather)
      end
    end
  end

  describe '.instance_methods' do
    let(:todays_weather) { DailyWeather.new(todays_weather_data) }

    context '#initialize' do
      it 'has_attributes' do
        expect(todays_weather.date).to eq(todays_weather_data[:date])
        expect(todays_weather.sunrise).to eq(todays_weather_data[:astro][:sunrise])
        expect(todays_weather.sunset).to eq(todays_weather_data[:astro][:sunset])
        expect(todays_weather.max_temp).to eq(todays_weather_data[:day][:maxtemp_f])
        expect(todays_weather.min_temp).to eq(todays_weather_data[:day][:mintemp_f])
        expect(todays_weather.condition).to eq(todays_weather_data[:day][:condition][:text])
        expect(todays_weather.icon).to eq(todays_weather_data[:day][:condition][:icon])
      end
    end
  end
end