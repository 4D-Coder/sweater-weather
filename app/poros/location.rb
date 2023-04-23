class Location
    attr_reader :data,
                :city_state,
                :coordinates

  def initialize(data)
    @data = data
    @city_state = @data[:results].first[:providedLocation][:location]
    @coordinates = coordinates
  end

  def location_data
    @data[:results].first[:locations].first
  end

  def coordinates
    hash = location_data[:latLng]
    "#{hash[:lat]},#{hash[:lng]}"
  end
end