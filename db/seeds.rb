# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	if Rails.env.development?
		additional_data = ENV["MAILGUN_DOMAIN_NAME"] + '|' + ENV["MAILGUN_KEY"]
		mailgun = 'Mailgun'
		send_to = ENV['SEND_EMAIL_TEST_EMAIL']

		#setting mailgun initial configuration
		sender = Sender.find_by(name: mailgun)

		if (sender.nil?)
			sender = Sender.create(:name => 'Mailgun', :active => true, :sender_class => 'Mailgun', :additional_data => additional_data, :send_to => send_to)
		end

		client_token = '112211'
		client = Client.find_by(token: client_token)
		if (client.nil?)
			client = Client.create(:token => client_token, :name => 'Test', :active => true, host: 'localhost')
		end

		client_sender = ClientSender.find_by(client: client, sender: sender)

		if (client_sender.nil?)
			client_sender = ClientSender.create(client: client, sender: sender)
		end

		client_host = ClientHost.find_by(:client => client)

		if(client_host.nil?)
			client_host = ClientHost.create(:client => client, host: 'localhost')
		end
	else

end