class SentEMessage < ActiveRecord::Base
	belongs_to :e_message
	belongs_to :sender
end
