class EMessage < ActiveRecord::Base
	
	validates :message,  :length => {
	    :minimum   => 10,
	    :maximum   => 100,
	    :too_short => "must have at least %{count} words",
	    :too_long  => "must have at most %{count} words"
	  }
	validates :subject,  :presence => { :message => "Field Required" }
	validates :sender_name,  :presence => { :message => "Field Required" }
	validates :sender_email,  :presence => { :message => "Field Required" }
	validates :token,  :presence => { :message => "Field Required" }

	has_one :sent_e_message
end
