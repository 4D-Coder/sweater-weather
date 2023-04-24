require 'rails_helper'

RSpec.describe TeleportApiService do
  describe 'instance methods' do
    context '#search_by_name(city)' do
      before do
        @city_params = "bozeman"
      end
      
      it 'can successfully make a request by city name' do
        VCR.use_cassette('GET search_by_name(city)') do
          response = TeleportApiService.new.search_by_name(@city_params)
    
          expect(response.status).to eq(200)

          json = JSON.parse(response.body, symbolize_names: true)
          
          expect(json).to have_key(:_embedded)
          expect(json[:_embedded]).to be_a Hash
          expect(json[:_embedded]).to have_key(:"city:search-results")
          expect(json[:_embedded][:"city:search-results"]).to be_an Array
          
          search_results = json[:_embedded][:"city:search-results"]

          search_results.each do |result|
            require 'pry'; binding.pry
            expect(result).to be_a Hash
            expect(result[:_links]).to be_a Hash
            expect(result[:links].keys).to eq

          end
          expect(search_result)
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