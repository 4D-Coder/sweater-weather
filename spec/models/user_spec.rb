require 'rails_helper'

RSpec.describe User, type: :model do
  puts "Running tests in #{Rails.env} environment..."

  before(:each) do
    @user = create(:user)
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should have_secure_password }
  end

  describe 'associations' do
    it { should have_many :api_keys }
  end
  
  it 'secure_password' do
    expect(@user.password_digest).to_not eq('password123')
    expect(@user).to_not have_attribute(:password)
  end 
end