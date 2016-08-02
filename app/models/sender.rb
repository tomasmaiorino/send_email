class Sender < ActiveRecord::Base
	has_many :sent_e_message
	has_many :client_sender
end
