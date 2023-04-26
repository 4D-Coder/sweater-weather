class User < ApplicationRecord
  before_create :generate_api_key

  validates :email,     presence: true,
                        uniqueness: true
  validates :api_key,   uniqueness: true, on: :update,
                        presence: :skip_new_user_validation
  validates :password,  presence: true,
                        confirmation: true
  has_secure_password

  private

  def generate_api_key
    self.api_key = SecureRandom.alphanumeric(26)
  end

  def skip_new_user_validation
    !persisted?
  end
end