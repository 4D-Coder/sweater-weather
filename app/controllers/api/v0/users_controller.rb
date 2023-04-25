class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(create_params)
    if user.valid?
      user.save
      render json: UserSerializer.new(user).serializable_hash, status: :created
    else
      serialized_errors = ErrorSerializer.new(user).serializable_hash
      render json: serialized_errors, status: :unprocessable_entity
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