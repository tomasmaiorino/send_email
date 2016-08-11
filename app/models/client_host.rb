class ClientHost < ActiveRecord::Base
	belongs_to :client

	validates :host,  :presence => { :message => "Field Required" }
	validates :client,  :presence => { :message => "Field Required" }

end
