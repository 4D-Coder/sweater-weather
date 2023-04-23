require 'rails_helper'

RSpec.describe Forecast do
  let(:location_coordinates) {"39.74001,-104.99202"}
  let(:forecast_data) do
    VCR.use_cassette('GET 5_day_forecast', record: :new_episodes ) do
      response = @weather_service.get_5_day_forecast_by(location_coordinates)
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe '.class_methods' do
    context '#initialize' do
      it 'exists' do
        forecast = Forecast.new
        expect(forecast).to be_a(Forecast)
      end
    end
  end

  describe '.instance_methods' do
    let(:forecast) { Forecatst.new(forecast_data)}
    context '#initialize' do
      it 'has_attributes' do
        
      end
    end
  end
end