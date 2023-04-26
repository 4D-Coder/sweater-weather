class DirectionsApiService
  def route(start_city, end_city)
    response = conn.get('/directions/v2/route') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['from'] = start_city
      req.params['to'] = end_city
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com')
  end
end