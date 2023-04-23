class MapquestGeoApiService
  def get_coordinates(city_state)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV["mapquest_api_key"]
      req.params['location'] = "#{city_state}"
    end
  end
  
  def conn
    Faraday.new(url: "https://www.mapquestapi.com") 
  end
end