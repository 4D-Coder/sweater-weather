class Forecast
  attr_reader :data

  def initialize(data = {}, type = "forecast")
    @id = nil
    @type = "forecast"
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = data[:forecast][:forecastday].map { |day_data| DailyWeather.new.(day_data) }
    @hourly_weather = data[:forecast][:forecastday][:hour].map { |hour_data| HourlyWeather.new(hour_data) }
  end
end