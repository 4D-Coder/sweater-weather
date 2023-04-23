require 'rails_helper'

RSpec.describe WeatherApiService do
  describe 'instance methods' do
    let(:weather_api_service) { WeatherApiService.new }

    context 'get_days_forecast_by(city)' do
      before do
        @location_coordinates = "39.74001,-104.99202"
      end

      it "can retreive 5-day forecast and hourly forecast for each day" do
        VCR.use_cassette('GET 5_day_forecast', record: :new_episodes ) do
          response = weather_api_service.get_5_day_forecast_by(@location_coordinates)

          expect(response.status).to eq(200)
          
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json.keys).to eq([:location, :current, :forecast])
          expect(json[:location]).to be_a Hash
          expect(json[:current]).to be_a Hash
          expect(json[:forecast]).to be_a Hash

          expect(json[:location][:name]).to be_a String
          expect(json[:location][:region]).to be_a String
          expect(json[:location][:country]).to be_a String
          expect(json[:location][:lat]).to be_a(Float)
          expect(json[:location][:lon]).to be_a(Float)
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

          forecastdays = json[:forecast][:forecastday]
          expect(forecastdays.count).to eq(5)

          forecastdays.each do |day|
            expect(day[:date]).to be_a String
            expect(day[:astro]).to be_a Hash
            expect(day[:astro][:sunrise]).to be_a String
            expect(day[:astro][:sunset]).to be_a String
            
            expect(day[:day]).to be_a Hash
            day_data = day[:day]

            expect(day_data[:maxtemp_f]).to be_a Float
            expect(day_data[:mintemp_f]).to be_a Float


            expect(day_data[:condition]).to be_a Hash
            expect(day_data[:condition][:text]).to be_a String
            expect(day_data[:condition][:icon]).to be_a String

            expect(day[:hour]).to be_an Array

            hours = day[:hour]
            expect(hours.count).to eq(24)

            hours.each do |hour|
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
    end
  end
end