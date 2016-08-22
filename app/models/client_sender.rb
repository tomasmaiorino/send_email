class ClientSender < ActiveRecord::Base
	belongs_to :sender
	belongs_to :client

	validates_presence_of :sender,  :client => { :message => "Field  Required" }
	validates_associated :sender,  :client => { :message => "Field  Invalid" }

end
