class ActivitiesFacade
  def get_activities(destination)
    forecast = WeatherApiService.new.get_5_day_forecast_by(destination)
    require 'pry'; binding.pry
    activities = BoredApiService.new.get_activities(destination)
  end
end