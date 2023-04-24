require 'rails_helper'

RSpec.describe SalaryFacade do
  describe '.class_methods' do
    context '#initialize' do 
      let(:teleport_service) { TeleportApiService.new. }
      let(:salary) { described_class.new() }

      it 'exists' do
        expect(forecast).to be_a(ForecastFacade)
      end

      it 'has attributes' do 
        expect(forecast.params).to be_a(Hash)
        expect(forecast.mapquest_service).to be_a(MapquestGeoApiService)
        expect(forecast.weather_service).to be_a(WeatherApiService)
      end
    end
  end

  describe '.instance_methods' do
    let(:map_quest_service) { MapquestGeoApiService.new }
    let(:weather_service) { WeatherApiService.new }
    
    before do
      @location_params = {"location"=>"denver,co"}
      @forecast_facade = described_class.new(map_quest_service, weather_service, @location_params)
    end

    context 'location_data' do
      it "can receive a location parameter and return a location object" do
        VCR.use_cassette('GET_mapquest_coordinates') do
          coordinates = @forecast_facade.location_coordinates

          expect(coordinates).to eq("39.74001,-104.99202")
        end
      end
    end

    context 'five_day_forecast' do
      it "returns forecast objects to be serialized" do
        VCR.use_cassette('GET_5_day_forecast', record: :new_episodes) do
          forecast = @forecast_facade.five_day_forecast

          expect(forecast.current_weather).to be_a(CurrentWeather)

          expect(forecast.daily_weather).to be_an Array
          expect(forecast.daily_weather.count).to eq(5)
          forecast.daily_weather.each do |day|
            expect(day).to be_a(DailyWeather)
          end
          
          expect(forecast.hourly_weather).to be_an Array
          expect(forecast.hourly_weather.count).to eq(24)
          forecast.hourly_weather.each do |hour|
            expect(hour).to be_a(HourlyWeather)
          end
        end
      end
    end
  end
end