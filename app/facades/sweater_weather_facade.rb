class SweaterWeatherFacade
  attr_reader :params,
              :weather_service,
              :mapquest_service
              
  def initialize(params = {})
    @mapquest_service = MapquestGeoApiService.new
    @weather_service = WeatherApiService.new
    @params = params
  end

end