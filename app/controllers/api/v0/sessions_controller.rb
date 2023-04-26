class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: create_params[:email])

    if user && user.authenticate(create_params[:password])
      render json: UsersSerializer.new(user), status: :ok
    else
      render json: ErrorSerializer.invalid_login, status: :bad_request
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
