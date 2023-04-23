require 'rails_helper'

RSpec.describe WeatherApiService do
  describe 'instance methods' do
    context 'get_days_forecast_by(city)' do
      before do
        VCR.use_cassette('GET_mapquest_coordinates') do
          response = MapquestGeoApiService.new.get_coordinates("Denver", "CO")
          json = JSON.parse(response.body, symbolize_names: true)

          @lat = json[:results].first[:locations].first[:latLng][:lat]
          @lng = json[:results].first[:locations].first[:latLng][:lng]
        end
      end

      it "can retreive current day's weather conditions and hourly forecast" do
        VCR.use_cassette('GET current_day_forecast') do
          response = WeatherApiService.new.get_days_forecast_by(@lat, @lng)
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json.keys).to eq([:location, :current, :forecast])
          expect(json[:location]).to be_a Hash
          expect(json[:current]).to be_a Hash
          expect(json[:forecast]).to be_a Hash

          expect(json[:location][:name]).to be_a String
          expect(json[:location][:region]).to be_a String
          expect(json[:location][:country]).to be_a String
          expect(json[:location][:lat]).to be_a(Float).and eq(@lat.round(2))
          expect(json[:location][:lon]).to be_a(Float).and eq(@lng.round(2))
          expect(json[:location][:tz_id]).to be_a String
          expect(json[:location][:localtime_epoch]).to be_an Integer
          expect(json[:location][:localtime]).to be_a String

          expect(json[:current][:last_updated]).to be_a String
          expect(json[:current][:temp_f]).to be_a Float
          expect(json[:current][:feelslike_f]).to be_a Float
          expect(json[:current][:humidity]).to be_an Integer
          expect(json[:current][:uv]).to be_a Float # Serialize as :uvi
          expect(json[:current][:vis_miles]).to be_a Float
          expect(json[:current][:condition]).to be_a Hash
          expect(json[:current][:condition][:text]).to be_a String
          expect(json[:current][:condition][:icon]).to be_a String

          expect(json[:forecast]).to be_a Hash
          expect(json[:forecast][:forecastday]).to be_an Array
          expect(json[:forecast][:forecastday][0][:hour]).to be_an Array

          forecast_day_hours = json[:forecast][:forecastday][0][:hour]
          
          expect(forecast_day_hours.count).to eq(24)

          forecast_day_hours.each do |hour|
            expect(hour[:time]).to be_a String
            expect(hour[:temp_f]).to be_a Float

            condition = hour[:condition]

            expect(condition).to be_a Hash
            expect(condition[:text]).to be_a String
            expect(condition[:icon]).to be_a String
          end
        end
      end
    end

    context 'get_5_day_forecast_by(city)' do
      before do
        VCR.use_cassette('GET_mapquest_coordinates') do
          response = MapquestGeoApiService.new.get_coordinates("Denver", "CO")
          json = JSON.parse(response.body, symbolize_names: true)

          @lat = json[:results].first[:locations].first[:latLng][:lat]
          @lng = json[:results].first[:locations].first[:latLng][:lng]
        end

        it "can retreive 5-day forecast data" do
          VCR.use_cassette('GET 5_day_forecast') do
            response = WeatherApiService.new.get_5_day_forecast_by(@lat, @lng)
            require 'pry'; binding.pry
            json = JSON.parse(response.body, symbolize_names: true)
          end
        end
      end
    end
  end
end