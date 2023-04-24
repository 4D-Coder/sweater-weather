class TeleportApiService
  # def search_by_name(city)
  #   conn.get('/api/cities/') do |req|
  #     req.headers['Accept'] = 'application/vnd.teleport.v1+json'
  #     req.headers['Content-Type'] = 'application/json'
  #     req.params['search'] = "#{city}"
  #   end
  # end

  def conn
    Faraday.new(url: "https://api.teleport.org") 
  end
end