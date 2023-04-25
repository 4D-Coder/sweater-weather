class User < ApplicationRecord
  before_create :generate_api_key

  validates :email, uniqueness: true,
                    presence: true
  validates :api_key, uniqueness: true
  validates :password,  presence: true,
                        confirmation: true
                      

  has_secure_password

  private

  def generate_api_key
    self.api_key = SecureRandom.alphanumeric(26)
  end
end