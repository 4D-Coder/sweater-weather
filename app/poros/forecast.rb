class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(data = {})
    @id = nil
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = data[:forecast][:forecastday].map { |day_data| DailyWeather.new(day_data) }
    @hourly_weather = data[:forecast][:forecastday].first[:hour].map { |hourly_data| HourlyWeather.new(hourly_data) }
  end
end
