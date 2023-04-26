FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    api_key { SecureRandom.alphanumeric(26) }
  end
end
