require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'user create' do
    context 'When successful' do
      let(:request_body) do
        {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }
      end
      let(:headers) { { "CONTENT_TYPE" => "application/json" } }

      it 'persists in the database' do
        post '/api/v0/users', params: request_body.to_json, headers: headers

        expect(response).to be_successful
        expect(response.status).to eq(201)
        
        new_user = User.last
        expect(new_user.email).to eq("whatever@example.com")

        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed[:data][:id]).to eq(new_user.id.to_s)
        expect(parsed[:data][:type]).to eq("users")
        expect(parsed[:data][:attributes][:email]).to eq(new_user.email)
        expect(parsed[:data][:attributes][:api_key]).to eq(new_user.api_key)

      end
    end

    context 'When unsuccessful' do
      let(:email_to_duplicate) { "whatever@example.com" }
      let(:headers) { { "CONTENT_TYPE" => "application/json" } }

      it 'Wont allow a user to be created with an email that already exists' do
        request_body = {
          email: email_to_duplicate,
          password: "password",
          password_confirmation: "password"
        }

        user = create(:user, email: email_to_duplicate)

        post '/api/v0/users', params: request_body.to_json, headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response[:data][:attributes][:message]).to eq("Email has already been taken")
      end

      it 'Wont allow a user to be created if passwords dont match' do
        request_body = {
          email: email_to_duplicate,
          password: "password",
          password_confirmation: "paswod"
        }

        post '/api/v0/users', params: request_body.to_json, headers: headers

        expect(response.status).to eq(422)

        error_response = JSON.parse(response.body, symbolize_names: true)
        
        expect(error_response[:data][:attributes][:message]).to eq("Password confirmation doesn't match Password")
      end
    end
  end
end