class Api::V0::RoadTripController < ApplicationController
  def create
    if request.query_parameters.present?
      serialized_errors = ErrorSerializer.invalid_payload
      render json: serialized_errors, status: :bad_request
    else
      user = User.find_by(api_key: create_params[:api_key])
      if !user.nil?
        trip = RoadTripFacade.new(create_params[:origin], create_params[:destination]).road_trip_summary
        render json: RoadTripSerializer.new(trip), status: :created
      end
    end
  end

  private

  def create_params
    params.permit(
      :origin,
      :destination,
      :api_key
    )
  end
end