require 'httparty'

class HealthResult
  attr_accessor :code, :http_code, :message
end

def check_API
  response = HTTParty.get('https://rest.ably.io')
  health_result = HealthResult.new
  health_result.http_code = response.code
  if response.code > 199 && response.code < 299
    health_result.code = true
  else
    health_result.code = false
    response_json = JSON.parse(response.body)
    error_object = response_json['error']
    if error_object
      health_result.message = error_object['message']
    end
  end
  health_result
end

result = check_API
puts result.inspect
