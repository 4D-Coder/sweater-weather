class DirectionsApiService
  def route(start_city, end_city)
    conn.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['from'] = start_city
      req.params['to'] = end_city
    end
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com')
  end
end