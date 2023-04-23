require 'rails_helper'

RSpec.describe Forecast do
  let(:location_coordinates) {"39.74001,-104.99202"}
  let(:forecast_data) do
    VCR.use_cassette('GET 5_day_forecast', record: :new_episodes ) do
      response = WeatherApiService.new.get_5_day_forecast_by(location_coordinates)
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe '.class_methods' do
    context '#initialize' do
      it 'exists' do
        forecast = Forecast.new(forecast_data)
        expect(forecast).to be_a(Forecast)
      end
    end
  end

  describe '.instance_methods' do
    let(:forecast) { Forecast.new(forecast_data)}
    context '#initialize' do
      it 'has_attributes' do
        expect(forecast.current_weather).to be_a(CurrentWeather)

        expect(forecast.daily_weather).to be_an Array
        expect(forecast.daily_weather.first).to be_a(DailyWeather)
        expect(forecast.daily_weather.count).to eq(5)
        
        expect(forecast.hourly_weather).to be_an Array
        expect(forecast.hourly_weather.first).to be_a(HourlyWeather)
        expect(forecast.hourly_weather.count).to eq(24)
      end
    end
  end
end