class SalaryFacade
  attr_reader :params,
              :weather_service,
              :mapquest_service

  def initialize(teleport_service, weather_service, params = {})
    @mapquest_service = mapquest_service
    @weather_service = weather_service
    @params = params
  end

  def location_coordinates
    response = @mapquest_service.get_coordinates(@params["location"])
    parsed = JSON.parse(response.body, symbolize_names: true)
    Location.new(parsed).coordinates
  end

  def five_day_forecast
    response = @weather_service.get_5_day_forecast_by(location_coordinates)
    parsed = JSON.parse(response.body, symbolize_names: true)
    Forecast.new(parsed)
  end
end