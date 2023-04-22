require 'rails_helper'

RSpec.describe WeatherApiService do
  describe 'instance methods' do
    context 'get_forecast_by(city)' do
      it 'can retreive weather for a city' do
        response = WeatherApiService.new.get_forecast_by("Denver")
        require 'pry'; binding.pry
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to eq(4)
      end

    end
  end
end