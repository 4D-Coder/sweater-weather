class Api::V0::UsersController < ApplicationController
  def create
    if request.query_parameters.present?
      serialized_errors = ErrorSerializer.invalid_payload
      render json: serialized_errors, status: :invalid_payload
    else
      user = User.create!(create_params)
      render json: UsersSerializer.new(user), status: :created
    end
  end

  private

  def create_params
    params.permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
