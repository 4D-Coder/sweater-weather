class Api::V0::SessionsController < ApplicationController
  def create
    if request.query_parameters.present?
      serialized_errors = ErrorSerializer.invalid_payload
      render json: serialized_errors, status: :bad_request
    else
      user = User.find_by(email: create_params[:email])

      if user && user.authenticate(create_params[:password])
        render json: UsersSerializer.new(user), status: :ok
      else
        render json: ErrorSerializer.invalid_login, status: :bad_request
      end
    end
  end

  private

  def create_params
    params.permit(
      :email,
      :password
    )
  end
end
