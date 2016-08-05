class Client < ActiveRecord::Base
	has_many :client_sender

	validates :name,  :presence => { :message => "Field Required" }
	validates :token,  :presence => { :message => "Field Required" }
	validates :host,  :presence => { :message => "Field Required" }

end
