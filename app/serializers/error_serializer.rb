class ErrorSerializer
  include JSONAPI::Serializer

  attribute :message do |object|
    object.errors.full_messages.pop
  end

  attribute :errors do |object|
    errors = object.errors.map do |error|
      error.full_message
    end
  end

  def self.bad_request
    { message: "Bad Request: Invalid query" }
  end
end