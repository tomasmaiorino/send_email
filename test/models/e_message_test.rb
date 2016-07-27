require 'test_helper'

class EMessageTest < ActiveSupport::TestCase

  test "shoul_save_e_message" do
  	message = EMessage.new
  	assert !message.valid?
  	assert !message.save

  	message.subject = 'subject'
  	message.sender_email = 'sender_email@test.com'

  	assert !message.valid?
  	assert !message.save

  	message.subject = 'subject'
  	message.sender_email = 'sender_email@test.com'
  	message.sender_name = 'sender name'

  	assert !message.valid?
  	assert !message.save

  	message.token = '123123'
  	message.message = 'test'

  	assert !message.valid?
  	assert !message.save
  	
  	message.message = 'test message test test message test test message test test message test test message test test message test test message test test message test'

  	assert !message.valid?
  	assert !message.save

  	message.message = 'This is a valid message.'

  	assert message.valid?
  	assert message.save

  	assert_not_nil message.id
  	assert_equal 'sender name', message.sender_name

  	assert EMessage.exists?(message.id)
  	assert_equal 'sender_email@test.com', EMessage.find_by(sender_email: 'sender_email@test.com').sender_email
  end

end
