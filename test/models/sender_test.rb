require 'test_helper'

class SenderTest < ActiveSupport::TestCase

 test "shoul_save_sender_message" do
 	sender = Sender.new
 	assert !sender.save
	assert !sender.valid?

 	sender.name = 'test'
 	assert !sender.valid?
	assert !sender.save

	sender.sender_from = 'user@contact.com'
 	assert sender.valid?
	assert sender.save
 end
end
