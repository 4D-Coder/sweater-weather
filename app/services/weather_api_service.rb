class WeatherApiService
  def get_forecast_by(lat, lng)
    response = conn.get('/v1/forecast.json') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['key'] = ENV["weather_api_key"]
      req.params['q'] = "#{lat},#{lng}"
      req.params['format'] = 'json'
    end
  end
  
  def conn
    Faraday.new(url: "http://api.weatherapi.com/") 
  end
end
  