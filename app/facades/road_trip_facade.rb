class RoadTripFacade
  attr_reader :start_city,
              :end_city

  def initialize(start_city, end_city)
    @start_city = start_city
    @end_city = end_city
  end

  def road_trip_summary
    route = DirectionsApiService.new.route(@start_city, @end_city)
    if route[:info][:statuscode] == 402
      impossible_trip = {
        id: nil,
        start_city: origin,
        end_city: destination,
        travel_time: "impossible",
        weather_at_eta: {}
      }

      InvalidTrip.new(impossible_trip)
    else
      forecast = WeatherApiService.new.get_5_day_forecast_by(@end_city)
      destination_forecast = JSON.parse(forecast.body, symbolize_names: true)

      RoadTrip.new(route, destination_forecast)
    end
  end
end