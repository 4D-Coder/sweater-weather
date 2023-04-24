require 'rails_helper'

RSpec.describe SalaryFacade do
  describe '.instance_methods' do
    context '#initialize' do 
      let(:mapquest_service) { MapquestGeoApiService.new }
      let(:weather_service) { WeatherApiService.new }
      let(:params) { "bozeman" }
      let(:forecast_facade) { ForecastFacade.new(mapquest_service, weather_service, params) }
      let(:teleport_service) { TeleportApiService.new }
      let(:salary_facade) { described_class.new(forecast_facade, teleport_service, params) }

      it 'exists' do
        expect(salary_facade).to be_a(SalaryFacade)
      end

      it 'has attributes' do 
        expect(salary_facade.params).to be_a String
        expect(salary_facade.forecast_facade).to be_a ForecastFacade
        expect(salary_facade.teleport_service).to be_a TeleportApiService
      end

      it 'can get_salaries' do
        VCR.use_cassette('GET search_salaries') do
          expect(salary_facade.get_salaries).to be_an(Array)
        end
      end
    end
  end
end