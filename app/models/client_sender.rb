class ClientSender < ActiveRecord::Base
	has_one :sender
	has_one :client
end
