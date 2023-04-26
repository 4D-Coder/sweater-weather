require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe 'session create (user login)' do
    context 'When successful' do
      let(:password) { 'password123' }
      let(:request_body) do
        {
          email: @user.email,
          password: password
        }
      end
      let(:headers) { { "CONTENT_TYPE" => "application/json" } }
      before(:each) do
        @user = User.create!(email: "keneth_satterfield@larson-daugherty.test", password: password, password_confirmation: password)
      end

      it 'can log in an authenticated user' do
        post '/api/v0/sessions', params: request_body.to_json, headers: headers

        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:data][:id]).to eq(@user.id.to_s)
        expect(parsed[:data][:type]).to eq("users")
        expect(parsed[:data][:attributes][:email]).to eq(@user.email)
        expect(parsed[:data][:attributes][:api_key]).to eq(@user.api_key)
      end
    end

    context 'When unsuccessful' do
      let(:password) { 'password123' }
      let(:headers) { { "CONTENT_TYPE" => "application/json" } }

      before(:each) do
        @user = User.create!(email: "keneth_satterfield@larson-daugherty.test", password: password, password_confirmation: password)
      end

      it "returns a serialized error when credentials are empty" do
        request_body = {
          email: "",
          password: ""
        }

        post '/api/v0/sessions', params: request_body.to_json, headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed[:message]).to eq("Bad Request: Invalid query")
      end

      it "returns a serialized error when email does not exist" do
        request_body = {
          email: "nonexistentemail@larson-daugherty.test",
          password: password
        }

        post '/api/v0/sessions', params: request_body.to_json, headers: headers

        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed[:message]).to eq("Bad Request: Invalid query")
      end

      it "returns a serialized error when email exist, but the password is incorrect" do
        request_body = {
          email: "keneth_satterfield@larson-daugherty.test",
          password: "wrongpassword"
        }
  
        post '/api/v0/sessions', params: request_body.to_json, headers: headers
  
        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed[:message]).to eq("Bad Request: Invalid query")
      end
    end
  end
end