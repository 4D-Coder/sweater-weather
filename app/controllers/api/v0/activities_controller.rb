class Api::V0::ActivitiesController < ApplicationController

  def show
    activities = ActivitiesFacade.new.get_activities(params[:destination])
    render json: ActivitiesSerializer.new(activities)
  end
  # def index
  #   mapquest_service = MapquestGeoApiService.new
  #   weather_service = WeatherApiService.new
  #   forecast = ForecastFacade.new(mapquest_service, weather_service, index_params).five_day_forecast

  #   render json: ForecastSerializer.new(forecast).serializable_hash, status: 200
  # end

  private

  def index_params
    params.permit(
      :location
    )
  end
end