class SentEMessage < ActiveRecord::Base
	has_one :e_message
	has_one :sender
end
