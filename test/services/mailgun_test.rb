require 'test_helper'
require 'mocha/test_unit'
require 'net/http'

class MailgunTest < BaseServiceTest

	def setup
    	initial_sender_client
    	@initial_url = "https://api:#{@key}@api.mailgun.net/v3/#{@domain_name}/messages"
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
  		assert_not_nil e_message.send_to
  		assert_equal @initial_url, e_message.url
  	end

    test "should send message" do
      mailgun = Mailgun.new
      e_message = create_e_message
      e_message.save
      response = mailgun.send_message(e_message, @sender)
      assert_not_nil response
      assert_equal 200, response.code
      sent_e_message = SentEMessage.find_by(e_message: e_message)
      assert_not_nil sent_e_message
      assert_equal e_message.id, sent_e_message.e_message.id
      assert_equal @sender.id, sent_e_message.sender.id
    end


end
