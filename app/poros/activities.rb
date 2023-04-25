class Activities
  attr_reader :id,
              :destination,
              :forecast,
              :activities

  def initialize(destination, forecast, bored_api_service)
    @id = nil
    @destination = destination
    @forecast = { summary: forecast.current_weather.condition, temperature: "#{forecast.current_weather.temperature.round} F"  }
    @activities = suitable_activities(forecast.current_weather.temperature, bored_api_service)
  end

  private

  def suitable_activities(current_temperature, bored_api_service)
    relaxation_activity = bored_api_service.get_activity("relaxation")
    activities = {
      relaxation_activity[:activity] => {
        type: relaxation_activity[:type],
        participants: relaxation_activity[:participants],
        price: relaxation_activity[:price]
      }
    }
    
    if current_temperature.round < 50
      cooking_activity = bored_api_service.get_activity("cooking")
      activities["#{cooking_activity[:activity]}"] = {
        type: cooking_activity[:type],
        participants: cooking_activity[:participants],
        price: cooking_activity[:price]
      }
    elsif current_temperature.round >= 50 && current_temperature.round < 60
      busywork_activity = bored_api_service.get_activity("busywork")
      activities["#{busywork_activity[:activity]}"] = {
        type: busywork_activity[:type],
        participants: busywork_activity[:participants],
        price: busywork_activity[:price]
      }
    elsif current_temperature.round >= 60
      recreational_activity = bored_api_service.get_activity("recreational")
      activities["#{recreational_activity[:activity]}"] = {
        type: recreational_activity[:type],
        participants: recreational_activity[:participants],
        price: recreational_activity[:price]
      }
    end

    activities
  end
end