class Api::V0::HomeController < ApplicationController

  def index
    render json: SweaterWeatherFacade.new(index_params).five_day_forecast, status: 200
  end

  private

  def index_params
    params.permit(
      :location
    )
  end
end