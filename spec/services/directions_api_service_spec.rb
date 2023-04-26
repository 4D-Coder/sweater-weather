require 'rails_helper'

RSpec.describe DirectionsApiService do
  describe 'instance methods', :vcr do
    context '#route' do
      let(:route) { DirectionsApiService.new.route("Missoula, MT", "Bozeman, MT")}
      
      it 'returns the route when given a start and end city,state' do
        expect(route).to be_a Hash
        expect(route).to have_key(:route)
        expect(route[:route]).to have_key(:formattedTime)
        expect(route[:route][:formattedTime]).to be_a String
      end
    end
  end
end