require 'test_helper'

class SendEMessageServiceTest < ActionController::TestCase

  def create_e_message
  	e_message = EMessage.new
  	e_message.id = 1
  	return e_message
  end 

  def create_sender
  	sender = Sender.new
  	sender.id = 1
  	return sender
  end

   test "should return nil" do
    service = SendEMessageService.new
    response = service.send_service_message(nil)
    assert_not_nil response
    assert_equal ConstClass::INTERNAL_ERROR.keys[0], response.code
    assert_equal nil, response.result 
  end

  test "should create error response" do
  	service = SendEMessageService.new
  	response = service.create_error_response(nil)
  	assert_not_nil response
  	assert_equal ConstClass::INTERNAL_ERROR.keys[0], response.code
  	assert_nil response.result
  end

  test "should create success response" do
	#init
  	service = SendEMessageService.new
  	sent_e_message = SentEMessage.new
  	sent_e_message.id = '1'
  	#call
  	response = service.create_success_response(sent_e_message)
  	#assert
  	assert_not_nil response
  	assert_equal ConstClass::SUCCESS.keys[0], response.code
  	assert_equal sent_e_message.id, response.result
  end

  test "should create sent message" do
  	#init
  	service = SendEMessageService.new
  	e_message = create_e_message
  	e_message.save
  	sender = create_sender
  	sender.save
  	sent_message = service.create_sent_message(e_message, sender)
  	assert_not_nil sent_message
  	assert_equal e_message.id, sent_message.e_message.id
  	assert_equal sender.id, sent_message.sender.id
  	assert_not_nil sent_message.date_sent
  end

end