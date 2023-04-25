class Api::V0::ActivitiesController < ApplicationController

  def show
    activities = ActivitiesFacade.new.get_activities(params[:destination])
    render json: ActivitiesSerializer.new(activities)
  end

  private

  def index_params
    params.permit(
      :location
    )
  end
end