class InvalidTrip
attr_reader :id,
            :start_city,
            :end_city,
            :weather_at_eta,
            :travel_time

  def initialize(impossible_trip)
    @id = impossible_trip[:id]
    @start_city = impossible_trip[:start_city]
    @end_city = impossible_trip[:end_city]
    @travel_time = impossible_trip[:travel_time]
    @weather_at_eta = impossible_trip[:weather_at_eta]
  end
end