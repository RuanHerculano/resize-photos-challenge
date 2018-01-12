class ResultResponseService
  attr_accessor :success, :response, :status

  def initialize(success, status, response)
    @success = success
    @status = status
    @response = response
  end
end
