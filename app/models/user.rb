class User < ApplicationRecord
  has_many :api_keys, as: :bearer
  
  validates_presence_of :email
  validates_uniqueness_of :email

  has_secure_password
end