class ErrorSerializer
  include JSONAPI::Serializer

  attribute :message do |object|
    errors = object.errors.map do |error|
      error.full_message
    end.join(", ")
  end

  def self.bad_request
    { message: "Bad Request: Invalid query" }
  end

  def self.not_found
    { message: "Not Found" }
  end

  def self.invalid_payload
    { message: "Access Denied: Invalid Payload"}
  end

  def self.unprocessable_entity
    { message: "Unprocessable Entity"}
  end
end