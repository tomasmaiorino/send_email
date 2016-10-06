class EMessage < ActiveRecord::Base

	@sender_from = nil
	@url = nil

	attr_accessor :send_to, :url

	validates :message,  :length => {
	    :minimum   => 10,
	    :maximum   => 200,
	    :too_short => "The message must have at least %{count} words",
	    :too_long  => "The message must have at most %{count} words"
	  }
	validates :subject,  :presence => { :message => "Field Required" }
	validates :sender_name,  :presence => { :message => "Field Required" }
	validates :sender_email,  :presence => { :message => "Field Required" }
	validates :token,  :presence => { :message => "Field Required" }

	has_one :sent_e_message
end
