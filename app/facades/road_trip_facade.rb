class RoadTripFacade
  def initialize(start_city, end_city)
    @start_city = start_city
    @end_city = end_city
  end

  def road_trip_summary
    route = DirectionsApiService.new.route(@start_city, @end_city)
  end
end