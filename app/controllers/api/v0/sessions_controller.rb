class Api::V0::SessionsController < ApplicationController
def create
    
  begin
    user = User.find_by(email: create_params[:email])
    user.authenticate(create_params[:password])

    render json: UsersSerializer.new(user), status: :ok
  rescue ActiveRecord::RecordInvalid
    serialized_errors = ErrorSerializer.new(e).serializable_hash
    render json: serialized_errors, status: :not_found
  rescue StandardError
    serialized_errors = ErrorSerializer.bad_request
    render json: serialized_errors, status: :bad_request
  end
end


  #   if !create_params[:password]
  #     serialized_errors = ErrorSerializer.missing
  #     render json: serialized_errors, status: :not_found
  #   elsif !user
  #     serialized_errors = ErrorSerializer.invalid_request
  #     render json: serialized_errors, status: :not_found
  #   elsif user && user.authenticate(create_params[:password]) 
  #     render json: UsersSerializer.new(user), status: :ok
  #   else
  #     serialized_errors = ErrorSerializer.new(user).serializable_hash
  #     render json: serialized_errors, status: :not_found
  #   end
  # end

  private

  def create_params
    params.permit(
      :email,
      :password
    )
  end
end