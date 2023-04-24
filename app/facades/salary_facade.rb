class SalaryFacade
  attr_reader :params,
              :forecast_facade,
              :teleport_service

  def initialize(teleport_service, params = {})
    @teleport_service = teleport_service
    @params = params
  end

  def get_salaries
    required_titles = [
      "Data Analyst", 
      "Data Scientist", 
      "Mobile Developer", 
      "QA Engineer",
      "Software Engineer",
      "Systems Administrator",
      "Web Developer"
    ]

    response = @teleport_service.search_salaries(@params)
    parsed = JSON.parse(response.body, symbolize_names: true)
    salaries = parsed[:salaries].map { |salary| Salary.new(salary) }
    required_titles = salaries.select do |salary|
      required_titles.include?(salary.title)
    end
  end

  def salaries_with_forecast

  end
end