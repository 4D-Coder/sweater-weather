class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :weather_at_eta,
              :travel_time

  def initialize(route, destination_forecast)
    @id = nil
    @start_city = "#{route[:route][:locations][0][:adminArea5]}, #{route[:route][:locations][0][:adminArea3]}"
    @end_city = "#{route[:route][:locations][-1][:adminArea5]}, #{route[:route][:locations][-1][:adminArea3]}"
    @weather_at_eta = destination_condititions(destination_forecast, route[:route][:realTime])
    @travel_time = route[:route][:formattedTime]
  end

  private

  def destination_condititions(destination_forecast, travel_time)
    arrival_time = Time.now + travel_time

    destination_forecast[:forecast][:forecastday].each do |day|
      if arrival_time.to_s.include?(day[:date])
        day[:hour].each do |hour|
          if arrival_time.between?(Time.parse(hour[:time]), (Time.parse(hour[:time]) + 3600))
            return {
              datetime: hour[:time],
              temperature: hour[:temp_f],
              condition: hour[:condition][:text]
            }
          end
        end
      end
    end
  end
end