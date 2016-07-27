class SendEMessageService

	def send_message(message) 
		return nil if message.nil?
		Rails.logger.info "send_message -> #{message.id}"

	end

	def create_sent_message(e_message)
		sent_message = SentEMessage.new		
	end
end