require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'user create' do
    context 'When successful' do
      let (:request_body) do
        {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        }
      end

      it 'post api/v0/users' do
        VCR.use_cassette('POST user_create') do
          post '/api/v0/users' do |req|
            require 'pry'; binding.pry
          end
          
          expect(response.status).to eq(200)

          forecast_json = JSON.parse(response.body, symbolize_names: true)

          expect(forecast_json).to have_key(:data)

          forecast_data = forecast_json[:data]
          expect(forecast_data.keys).to eq([:id, :type, :attributes])
          expect(forecast_data[:id]).to be_nil
          expect(forecast_data[:type]).to eq("forecast")
          expect(forecast_data[:attributes]).to be_a Hash

          attributes = forecast_data[:attributes]
          expect(attributes.keys).to eq([:current_weather, :daily_weather, :hourly_weather])
          
          current_weather = attributes[:current_weather]
          expect(current_weather).to be_a Hash
          expect(current_weather[:last_updated]).to be_a String
          expect(current_weather[:temperature]).to be_a Float
          expect(current_weather[:feels_like]).to be_a Float
          expect(current_weather[:humidity]).to be_a(Float).or be_an(Integer)
          expect(current_weather[:uvi]).to be_a(Float).or be_an(Integer)
          expect(current_weather[:visibility]).to be_a(Float).or be_an(Integer)
          expect(current_weather[:condition]).to be_a String
          expect(current_weather[:icon]).to be_a String
          
          expect(attributes[:daily_weather]).to be_an Array
          attributes[:daily_weather].each do |day|
            expect(day.keys).to eq([
              :date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon
            ])
            expect(day[:date]).to be_a String
            expect(day[:sunrise]).to be_a String
            expect(day[:sunset]).to be_a String
            expect(day[:max_temp]).to be_a Float
            expect(day[:min_temp]).to be_a Float
            expect(day[:condition]).to be_a String
            expect(day[:icon]).to be_a String
          end

          expect(attributes[:hourly_weather]).to be_an Array
          attributes[:hourly_weather].each do |hour|
            expect(hour.keys).to eq([
              :time, :temperature, :condition, :icon
            ])
            expect(hour[:time]).to be_a String
            expect(hour[:temperature]).to be_a Float
            expect(hour[:condition]).to be_a String
            expect(hour[:icon]).to be_a String
          end
        end
      end
    end
  end
end