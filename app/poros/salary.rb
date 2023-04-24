class Salary
  attr_reader :title,
              :minimum_salary,
              :maximum_salary

  def initialize(data = {})
    @title = data[:job][:title]
    @minimum_salary = data[:salary_percentiles][:percentile_25].round(2)
    @maximum_salary = data[:salary_percentiles][:percentile_75].round(2)
  end
end
