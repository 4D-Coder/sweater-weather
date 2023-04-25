class BoredApiService
  def get_activity(type)
    response = conn.get('/api/activity') do |req|
      req.params["type"] = type
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "http://www.boredapi.com") 
  end
end