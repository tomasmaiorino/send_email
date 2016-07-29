class SendEMessageService

	def send_service_message(e_message)

		return create_error_response(e_message) if e_message.nil?

		Rails.logger.debug "looking for sender for token #{e_message.token}"

		client = Client.find_by(token: e_message.token, active: true)

		sender_client = ClientSender.find_by(client: client.id)

		Rails.logger.debug "Sender found ? #{!sender.nil?}"
		return create_error_response('sender not found') if sender_client.sender.nil?
		
		Rails.logger.debug "Loading sender"
		sender_class = sender_class.sender_class.classify.safe_constantize.new
		Rails.logger.info "send_message -> #{e_message.id}"
		response = sender_class.send_message(sender, e_message)
		Rails.logger.info "send_message <- #{e_message.id}"
		
		
	end

	def does_call(e_message, url, sender)
		RestClient.post url,
  			:from => sender.sender_from,
  			:to => e_message.sender_email,
  			:subject => e_message.subject,
  			:text => e_message.message
	end

	def create_sent_message(e_message, sender)
		sent_message = SentEMessage.new
		sent_message.date_sent =  DateTime.now
		sent_message.e_message = e_message
		sent_message.sender = sender
		sent_message.message = 'sent'
		return sent_message
	end

	def create_success_response(sent_message)
		return Response.new(ConstClass::SUCCESS.values[0], ConstClass::SUCCESS.keys[0], sent_message.id)
	end

	def create_error_response(e_message)
		return Response.new(ConstClass::INTERNAL_ERROR.values[0], ConstClass::INTERNAL_ERROR.keys[0], e_message)
	end	
end