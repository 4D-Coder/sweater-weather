class WeatherApiService
  def get_5_day_forecast_by(location_coordinates)
    response = conn.get('/v1/forecast.json') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['days'] = 5
      req.params['key'] = ENV["weather_api_key"]
      req.params['q'] = location_coordinates
      req.params['format'] = 'json'
    end
  end

  def conn
    Faraday.new(url: "http://api.weatherapi.com/") 
  end
end
  