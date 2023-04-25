require 'rails_helper'

RSpec.describe User, type: :model do
  puts "Running tests in #{Rails.env} environment..."

  before(:each) do
    @password = 'password123'

    @user = create(:user, password: @password, password_confirmation: @password)
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :api_key }
    it { should validate_uniqueness_of :api_key }
    it { should have_secure_password }
  end
  
  it 'secure_password' do
    expect(@user.password_digest).to_not eq(@password)
    expect(@user).to_not have_attribute(:password)
  end 

  it 'generate_api_key' do
    expect(@user.api_key).to be_present
  end
end