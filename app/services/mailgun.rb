class Mailgun < SendEMessageService

	def send_message(e_message, sender)
		return Response.new(ConstClass::BAD_REQUEST.values[0], ConstClass::BAD_REQUEST.keys[0], nil) if e_message.nil?
		#configure e_message
		e_message = configure_sent_message(sender, e_message)
		#does the call
		response = does_post_call(e_message, sender)
		sent_message = create_sent_message(e_message, sender, response, true)
		e_response = create_success_response(sent_message)
		return e_response
	end

	def configure_sent_message(sender, e_message)
		if !sender.nil?
			additional_data = sender.additional_data.split('|')
			key = additional_data[1]
			domain_name = additional_data[0]
			url = "https://api:#{key}@api.mailgun.net/v3/#{domain_name}/messages"			
			e_message.send_to = sender.send_to
			e_message.url = url
			return e_message
		end
	end

end