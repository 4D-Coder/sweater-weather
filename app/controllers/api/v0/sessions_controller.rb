class Api::V0::SessionsController < ApplicationController
def create
    
  begin
    user = User.find_by(email: create_params[:email])
    raise StandardError unless user.authenticate(create_params[:password])

    render json: UsersSerializer.new(user), status: :ok
  rescue StandardError
    serialized_errors = ErrorSerializer.bad_request
    render json: serialized_errors, status: :bad_request
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