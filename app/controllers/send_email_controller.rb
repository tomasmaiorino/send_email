require 'ostruct'
require 'json'

class SendEmailController < BaseApiController

	def initialize
		@send_message_service = SendEMessageService.new
	end

	def handle_unverified_request
		if request.method == 'POST' && !JSON.parse(request.body.read).has_key?("token")
       		raise ActionController::InvalidAuthenticityToken
       	end
    end

	def send_email
		
		if (@json.nil?) 
			return render nothing: true, status: :bad_request
		end

		Rails.logger.debug "EMessage #{@json.to_s}"
		message = JSON.parse( @json.to_json, object_class: EMessage)
		Rails.logger.debug "EMessage #{message}"
		if !message.valid?
   			return render json: message.errors.to_json, status: :bad_request
   		end

   		Rails.logger.debug "[EMessage] -> saving e_message."
   		message.save()
   		Rails.logger.debug "[EMessage] <- saving e_message."

   		# checking token against host
   		
   		if is_invalid_client(message)
   			return render json: Response.new(ConstClass::INVALID_CLIENT.values[0], ConstClass::INVALID_CLIENT.keys[0]), status: :bad_request
   		end
   		# send the email
   		Rails.logger.info "[EMessage] -> sending email."

   		return render json: Response.new(ConstClass::SUCCESS.values[0], ConstClass::SUCCESS.keys[0]), status: :ok
  	end

  	private

  	def is_invalid_client(e_message)
  		Rails.logger.debug "Client host " << request.host
  		Client.find_by(token: e_message.token, active: true, host: request.host).nil?
  	end
end
