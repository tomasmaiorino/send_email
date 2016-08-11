require 'ostruct'
require 'json'

class SendEmailController < BaseApiController

  after_action :set_headers 

  skip_before_action :verify_authenticity_token

	def initialize
		@send_message_service = SendEMessageService.new
	end

	def handle_unverified_request
		if request.method == 'POST' || request.method == 'OPSTIONS' && !JSON.parse(request.body.read).has_key?("token")
       		raise ActionController::InvalidAuthenticityToken
       	end
    end

	def send_email
  	if (@json.nil?)
      Rails.logger.debug "Json nil :("
			return render nothing: true, status: :bad_request
		end
		Rails.logger.debug "EMessage #{@json.to_s}"
		message = JSON.parse( @json, object_class: EMessage)
		Rails.logger.debug "EMessage #{message}"
	  if !message.valid?
 			return render json: message.errors.to_json, status: :bad_request
 		end
 		Rails.logger.debug "[EMessage] -> saving e_message."
    message.is_message_valid = true
    message.save
 		Rails.logger.debug "[EMessage] <- saving e_message."

 		# checking token against host
 		if is_invalid_client(message)
      message.code = ConstClass::INVALID_CLIENT.keys[0]
      message.save
 			return render json: Response.new(ConstClass::INVALID_CLIENT.values[0], ConstClass::INVALID_CLIENT.keys[0]), status: :bad_request
 		end
 		# send the email
 		Rails.logger.info "[EMessage] -> sending email."
    send_response = @send_message_service.send_service_message(message)
    render json:send_response
    #  return render json: Response.new(ConstClass::SUCCESS.values[0], ConstClass::SUCCESS.keys[0], message.id), status: :ok
 	end

 	private
  	def is_invalid_client(e_message)
  		Rails.logger.debug "Client host " << request.host
  		Client.find_by(token: e_message.token, active: true, host: request.host).nil?
  	end

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Expose-Headers'] = 'Etag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*, x-requested-with, Content-Type, If-Modified-Since, If-None-Match'
      headers['Access-Control-Max-Age'] = '86400'
    end

end
