require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  puts "Running tests in #{Rails.env} environment..."

  before(:each) do
    @api_key = SecureRandom.hex
  end

  describe 'validations' do
    it { should belong_to :bearer }
  end
end