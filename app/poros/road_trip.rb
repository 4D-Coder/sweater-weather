class RoadTrip
  attr_reader

  def initialize(route, destination_forecast)
    @id = nil
    @start_city =
    @end_city =
    @weather_at_eta = 
    @travel_time = 
  end

  private

  def destination_condititions(destination_forecast, travel_time)
    arrival_time = Time.now + travel_time

    destination_forecast[:forecast][:forecastday].each do |day|
      require 'pry'; binding.pry
    end
  end
end