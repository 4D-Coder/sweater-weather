require 'rails_helper'

RSpec.describe TeleportApiService do
  describe 'instance methods' do
    context '#search_urban(urban_area)' do

      let(:ua) { "bozeman" } 

      
      it 'can successfully make a request by city name' do
        VCR.use_cassette('GET search_salaries(urban_area)', record: :new_episodes) do
          response = TeleportApiService.new.search_salaries(ua)
    
          expect(response.status).to eq(200)
          
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json).to have_key(:salaries)
          expect(json[:salaries]).to be_an Array

          json[:salaries].each do |salary|
            expect(salary).to be_a Hash
            expect(salary.keys).to eq([:job, :salary_percentiles])
            
            expect(salary[:job]).to be_a Hash
            expect(salary[:job][:id]).to be_a String
            expect(salary[:job][:title]).to be_a String

            expect(salary[:salary_percentiles]).to be_a Hash
            expect(salary[:salary_percentiles].keys).to eq([:percentile_25, :percentile_50, :percentile_75])
            expect(salary[:salary_percentiles][:percentile_25]).to be_a Float
            expect(salary[:salary_percentiles][:percentile_50]).to be_a Float
            expect(salary[:salary_percentiles][:percentile_75]).to be_a Float
          end
        end
      end
    end
  end
end