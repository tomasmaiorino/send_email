class Sender < ActiveRecord::Base
	has_many :sent_e_message
	has_many :client_sender

	validates :name,  :presence => { :message => "Field Required" }
	validates :sender_from,  :presence => { :message => "Field Required" }

end
