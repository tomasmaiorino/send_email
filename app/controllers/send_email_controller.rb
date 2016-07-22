class SendEmailController < BaseApiController

	def handle_unverified_request
	#	if !@json.has_key?('message') && !@json['message']['api_token']
     #  		raise ActionController::InvalidAuthenticityToken
      # 	end
    end

	def send_email
		render json: @json
	end
end
