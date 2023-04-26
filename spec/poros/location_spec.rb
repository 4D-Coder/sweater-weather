require 'rails_helper'

RSpec.describe Location do
  let(:denver_location_data) do
    {
      info: {
        statuscode: 0,
        copyright: {
          text: '© 2022 MapQuest, Inc.',
          imageUrl: 'http://api.mqcdn.com/res/mqlogo.gif',
          imageAltText: '© 2022 MapQuest, Inc.'
        },
        messages: []
      },
      options: {
        maxResults: -1,
        ignoreLatLngInput: false
      },
      results: [{
        providedLocation: {
          location: 'denver,co'
        },
        locations: [{
          street: '',
          adminArea6: '',
          adminArea6Type: 'Neighborhood',
          adminArea5: 'Denver',
          adminArea5Type: 'City',
          adminArea4: 'Denver',
          adminArea4Type: 'County',
          adminArea3: 'CO',
          adminArea3Type: 'State',
          adminArea1: 'US',
          adminArea1Type: 'Country',
          postalCode: '',
          geocodeQualityCode: 'A5XAX',
          geocodeQuality: 'CITY',
          dragPoint: false,
          sideOfStreet: 'N',
          linkId: '0',
          unknownInput: '',
          type: 's',
          latLng: {
            lat: 39.74001,
            lng: -104.99202
          },
          displayLatLng: {
            lat: 39.74001,
            lng: -104.99202
          },
          mapUrl: ''
        }]
      }]
    }
  end

  before do
    @location = Location.new(denver_location_data)
  end

  describe '.class_methods' do
    context '#initialize' do
      it 'exists' do
        expect(@location).to be_a Location
      end
    end
  end

  describe '.instance_methods' do
    context '#intialize' do
      it 'has attributes' do
        expect(@location.data).to eq(denver_location_data)
        expect(@location.city_state).to be_a String
        expect(@location.coordinates).to be_a String
      end
    end

    context '#location_data' do
      it "extracts the city_states' data from the parameter" do
        expect(@location.location_data).to eq(denver_location_data[:results][0][:locations][0])
      end
    end

    context '#coordinates' do
      it 'extracts coordinate values from the data and turns it into a string' do
        expect(@location.coordinates).to eq('39.74001,-104.99202')
      end
    end
  end
end
