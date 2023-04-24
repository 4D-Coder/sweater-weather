require 'rails_helper'

RSpec.describe TeleportApiService do
  describe 'instance methods' do
    context '#search_by_name(city)' do
      before do
        @city_params = "bozeman"
      end

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
            expect(result).to be_a Hash
            expect(result.keys).to eq([:_links, :matching_alternate_names, :matching_full_name])
            
            expect(result[:_links]).to be_a Hash
            expect(result[:_links][:"city:item"]).to be_a Hash
            expect(result[:_links][:"city:item"][:href]).to be_a String
            
            expect(result[:matching_alternate_names]).to be_an Array

            result[:matching_alternate_names].each do |name|
              expect(name).to be_a Hash
              expect(name[:name]).to be_a String
            end

            expect(result[:matching_full_name]).to be_a String
          end
        end
      end
    end
  end
end