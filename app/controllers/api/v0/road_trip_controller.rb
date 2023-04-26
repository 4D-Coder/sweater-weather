class Api::V0::RoadTripController < ApplicationController
  def create
    if request.query_parameters.present?
      serialized_errors = ErrorSerializer.invalid_payload
      render json: serialized_errors, status: :bad_request
    else
      require 'pry'; binding.pry
      user = User.find_by(create_params[:api_key])
      trip = RoadTripFacade.new(user, create_params[:origin], create_params[:destination])
      render json: RoadTripSerializer.new(trip), status: :created
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