require 'test_helper'
require 'mocha/test_unit'
require 'net/http'

class BaseServiceTest < ActionController::TestCase

	def initial_sender_client
  
	    @domain_name = ENV["MAILGUN_DOMAIN_NAME"]
	    @key = ENV["MAILGUN_KEY"]

	    additional_data = @domain_name + '|' + @key
	    mailgun = 'Mailgun'

	    @mailgun_test_url = "https://api:#{@key}@api.mailgun.net/v3/#{@domain_name}/messages"

	    #setting mailgun initial configuration
	    @sender = Sender.find_by(name: 'Mailgun')

	    if (@sender.nil?)
	      @sender = Sender.create(:name => 'Mailgun', :active => true, :sender_class => 'Mailgun', 
	      			:additional_data => additional_data, :sender_from => 'from@')
	    end

	    client_token = '112211'
	    client = Client.find_by(token: client_token)
	    if (client.nil?)
	      client = Client.create(:token => client_token, :name => 'Test', :active => true, host: 'localhost')
	    end

	    client_sender = ClientSender.find_by(client: client, sender: @sender)
	    if (client_sender.nil?)
	      client_sender = ClientSender.create(client: client, sender: @sender)
	    end
  	end

	def create_e_message(persist = false)
	  	e_message = EMessage.new
	    e_message.token = '112211'
	    e_message.message = 'Test Message'
    	e_message.sender_email = ENV["SEND_EMAIL_TEST_EMAIL"]
	    e_message.sender_name = 'test email'
	    e_message.subject = 'subject'
	  	if persist
			e_message.save
	  	end
	  	return e_message
  	end 

	def create_sender
	  	sender = Sender.new
	  	sender.id = 1
	  	return sender
  	end



end