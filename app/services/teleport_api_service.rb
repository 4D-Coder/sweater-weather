class TeleportApiService
  def search_salaries(urban_area)
    conn.get("/api/urban_areas/slug:#{urban_area}/salaries") do |req|
      req.headers['Accept'] = 'application/vnd.teleport.v1+json'
      req.headers['Content-Type'] = 'application/json'
    end
  end

  def conn
    Faraday.new(url: "https://api.teleport.org") 
  end
end