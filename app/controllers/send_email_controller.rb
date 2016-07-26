require 'ostruct'
require 'json'

class SendEmailController < BaseApiController

	def handle_unverified_request
	#	if !@json.has_key?('message') && !@json['message']['api_token']
     #  		raise ActionController::InvalidAuthenticityToken
      # 	end
    end

	def send_email
		
		if (@json.nil?) 
			return render nothing: true, status: :bad_request
		end

		Rails.logger.debug "EMessage #{@json}"
		message = JSON.parse( @json.to_json, object_class: EMessage)
		Rails.logger.debug "EMessage #{message}"
		if !message.valid?
   			return render json: message.errors.to_json, status: :bad_request
   		end
  	end
end
