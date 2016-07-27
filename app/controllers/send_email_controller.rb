require 'ostruct'
require 'json'

class SendEmailController < BaseApiController

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
   		#message.save()
   		Rails.logger.info "[EMessage] -> sending email."

   		return render json: Response.new('success', 200), status: :ok
  	end
end
