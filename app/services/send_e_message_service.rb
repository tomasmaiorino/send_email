class SendEMessageService

	def send_message(e_message)

		return create_error_response(e_message) if e_message.nil?

		Rails.logger.debug "looking for sender for token #{e_message.token}"

		client = Client.find_by(token: e_message.token, active: true)

		sender = ClientSender.find_by(client: client.id).sender

		Rails.logger.debug "Sender found ? #{!sender.nil?}"
		return create_error_response('sender not found') if sender.nil?
		
		Rails.logger.debug "Loading sender"
		sender_class = sender_class.sender_class.classify.safe_constantize.new
		Rails.logger.info "send_message -> #{e_message.id}"
		response = sender_class.send_message(client, e_message)
		Rails.logger.info "send_message <- #{e_message.id}"
		
		
	end

	def create_sent_message(e_message)
		sent_message = SentEMessage.new		
	end

	def create_error_response(e_message)
		return Response.new(ConstClass::INTERNAL_ERROR.values[0], ConstClass::INTERNAL_ERROR.keys[0], e_message)
	end	
end