class Mailgun

	def send_message(e_message)
		return Response.new(ConstClass::BAD_REQUEST.values[0], ConstClass::BAD_REQUEST.keys[0], nil) if e_message.nil?
	end

end