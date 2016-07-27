class SentEMessage < ActiveRecord::Base
	has_one :emessage
	has_one :sender
end
