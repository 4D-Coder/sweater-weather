class Activities
  attr_reader :id,
              :destination,
              :forecast,
              :activities

  def initialize(destination, forecast, activities_service)
    @id = nil
    @destination = destination
    @forecast = { summary: forecast.current_weather.condition, temperature: "#{forecast.current_weather.temperature.round} F"  }
    require 'pry'; binding.pry
    @activities = suitable_activities(forecast.current_weather.temperature.round)
    
  end

  private

  def suitable_activities(current_temperature)

  end
end