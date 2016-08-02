class ClientSender < ActiveRecord::Base
	belongs_to :sender
	belongs_to :client
end
