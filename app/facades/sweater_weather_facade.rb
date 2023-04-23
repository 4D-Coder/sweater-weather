class SweaterWeatherFacade
  attr_reader :params,
              :weather_service,
              :mapquest_service

  def initialize(params = {})
    @mapquest_service = MapquestGeoApiService.new
    @weather_service = WeatherApiService.new
    @params = params
  end
  
  def five_day_forecast
    coordinates = location_data.coordinates
    require 'pry'; binding.pry
  end

  def location_data 
    response = @mapquest_service.get_coordinates(@params["location"])
    parsed = JSON.parse(response.body, symbolize_names: true)
    Location.new(parsed)
  end
end