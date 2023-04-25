class ActivitiesFacade
  def get_activities(destination)
    response = WeatherApiService.new.get_5_day_forecast_by(destination)
    parsed = JSON.parse(response.body, symbolize_names: true)
    forecast = Forecast.new(parsed)
    activities = BoredApiService.new.get_activities(destination)
    require 'pry'; binding.pry
    Activities.new(forecast_poro, activities)
  end
end