class WeatherApiService
  def get_forecast_by(city)
    # endpoint = '/v1/current.json'
    # response = conn.get(endpoint, params)
    # params = { key: ENV["weather_api_key"], q: city, format: 'json' }
    response = conn.get('/v1/current.json') do |req|
      # req.headers['Content-Type'] = 'application/json'
      req.params['key'] = ENV["weather_api_key"]
      req.params['q'] = city
      req.params['format'] = 'json'
    end
  end
  
  def conn
    Faraday.new(url: "http://api.weatherapi.com/") 
  end
end
  