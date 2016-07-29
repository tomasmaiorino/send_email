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
		mailgun_url = configure_mailgun_url(sender)
		does_call(e_message, mailgun, sender)
		sent_message = create_sent_message(e_message, sender)
		response = create_success_response(sent_message)
	end

end