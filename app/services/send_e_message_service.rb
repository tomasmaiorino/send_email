class SendEMessageService

	def send_service_message(e_message)

		return create_error_response(e_message) if e_message.nil?

		Rails.logger.debug "looking for sender for token #{e_message.token}"

		client = Client.find_by(token: e_message.token, active: true)

		sender_client = ClientSender.find_by(client: client.id)

		Rails.logger.debug "Sender found ? #{!sender_client.nil?}"
		return create_error_response('sender not found') if sender_client.sender.nil?
		
		Rails.logger.debug "Loading sender"
		Rails.logger.info "sender_client.sender #{sender_client.sender}"
		sender_class = sender_client.sender.sender_class.classify.safe_constantize.new
		Rails.logger.info "send_message -> #{e_message.id}"
		response = sender_class.send_message(e_message, sender_client.sender)
		Rails.logger.info "send_message <- #{e_message.id}"
		return response
	end

	#tested
	def create_sent_message(e_message, sender, response, save = false)
		sent_e_message = SentEMessage.new
		sent_e_message.status = response.code
		sent_e_message.e_message = e_message
		sent_e_message.sender = sender
		sent_e_message.message = response.code
		if save
			Rails.logger.debug("Saving sent_e_message.")	
			sent_e_message.save
		end
		return sent_e_message
	end

	#tested
	def does_post_call(e_message, sender)
		Rails.logger.debug("does_post_call -> ")
		Rails.logger.debug("e_message.url: #{e_message.url}")
		Rails.logger.debug("e_message.sender_from: #{e_message.sender_from}")
		Rails.logger.debug("e_message.sender_email: #{e_message.sender_email}")
		Rails.logger.debug("e_message.message: #{e_message.message}")
		Rails.logger.debug("e_message.subject: #{e_message.subject}")

		response = RestClient.post e_message.url,
		  :from => e_message.sender_from,
		  :to => e_message.sender_email,
		  :subject => e_message.subject,
		  :text => e_message.message
		Rails.logger.debug("does_post_call <- ")
		return response
	end

	#tested
	def create_success_response(sent_message)
		return Response.new(ConstClass::SUCCESS.values[0], ConstClass::SUCCESS.keys[0], sent_message.id)
	end

	#tested
	def create_error_response(e_message)
		return Response.new(ConstClass::INTERNAL_ERROR.values[0], ConstClass::INTERNAL_ERROR.keys[0], e_message)
	end	
end