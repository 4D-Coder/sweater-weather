class ActivitiesFacade
  def get_activities(destination)
    response = WeatherApiService.new.get_5_day_forecast_by(destination)
    parsed = JSON.parse(response.body, symbolize_names: true)
    forecast = Forecast.new(parsed)
    activities_service = BoredApiService.new
    Activities.new(destination, forecast, activities_service)
  end
end