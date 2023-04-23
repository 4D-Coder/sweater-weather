require 'rails_helper'

RSpec.describe MapquestGeoApiService do
  describe 'instance methods' do
    context 'get_coordinates(city, state)' do
      before do
        @location_params = {"location"=>"denver,co"}
      end
      
      it 'You can pass it a city, state, and it returns co-ordinates' do
        VCR.use_cassette('GET mapquest coordinates') do
          response = MapquestGeoApiService.new.get_coordinates(@location_params)

          expect(response.status).to eq(200)

          json = JSON.parse(response.body, symbolize_names: true)
          
          expect(json.keys).to include(:results)
          expect(json.keys).to include(:options)
          expect(json[:options][:ignoreLatLngInput]).to eq(false)

          expect(json[:results]).to be_an Array
          expect(json[:results]).to be_an Array
          
          expect(json[:results][0][:providedLocation]).to be_a Hash
          expect(json[:results][0][:locations]).to be_an Array
          
          location_info = json[:results][0][:locations].first
          
          expect(location_info[:latLng]).to be_a Hash
          expect(location_info[:latLng][:lat]).to be_a Float
          expect(location_info[:latLng][:lng]).to be_a Float
        end
      end
    end
  end
end