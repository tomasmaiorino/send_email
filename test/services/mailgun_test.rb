require 'test_helper'
require 'mocha/test_unit'
require 'net/http'

class MailgunTest < BaseServiceTest

	def setup
    	initial_sender_client
    	@initial_url = 'https://api:#{@key}@api.mailgun.net/v3/#{@domain_name}/messages'
  	end

  	test "should return nil calling configure_sent_message" do
  		mailgun = Mailgun.new
  		e_message = mailgun.configure_sent_message(nil, nil)
  		assert_nil e_message
  	end

  	test "should return valid mailgun url" do
  		mailgun = Mailgun.new
  		e_message = create_e_message
  		e_message.save
  		e_message = mailgun.configure_sent_message(@sender, e_message)
  		assert_not_nil e_message
  		assert_not_nil e_message.url
  		assert_not_nil e_message.sender_from
  		assert_equal @initial_url, e_message.url
  	end

end
