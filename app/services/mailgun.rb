class Mailgun < SendEMessageService

=begin
RestClient.post "https://api:#{key}"\
  "@api.mailgun.net/v3/#{domain_name}/messages",
  :from => "Excited User <mailgun@#{domain_name}>",
  :to => "tomasmaiorino@gmail.com",
  :subject => "Hello",
  :text => "Testing some Mailgun awesomness!"		

  	key = ENV["MAILGUN_KEY"]
  		domain_name = ENV['MAILGUN_DOMAIN_NAME']
=end
	def send_message(e_message, sender)
		return Response.new(ConstClass::BAD_REQUEST.values[0], ConstClass::BAD_REQUEST.keys[0], nil) if e_message.nil?
		e_message = configure_sent_message(sender)
		sender.sender_from = e_message.sender_from
		does_call(e_message, e_message.url, sender)
		does_call(e_message,  sender)
		sent_message = create_sent_message(e_message, sender)
		response = create_success_response(sent_message)
	end


	def create_sent_message(e_message, sender)

	end

	def does_call(e_message, sender)
		RestClient.post e_message.url,
		  :from => e_message.from_email,
		  :to => e_message.sender_email,
		  :subject => e_message.e_message,
		  :text => e_message.message		
	end

	def configure_sent_message(sender, e_message)
		if !sender.nil?
			addtional_data = sender.additional_data.split('|')
			key = additional_data[1]
			domain_name = additional_data[0]
			url = "https://api:#{key}@api.mailgun.net/v3/#{domain_name}/messages"
			e_message.sender_from = sender.sender_from << domain_name
			e_message.url = url
			return e_message
		end
	end

end