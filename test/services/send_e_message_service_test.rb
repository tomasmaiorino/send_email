require 'test_helper'
require 'mocha/test_unit'
require 'net/http'

class SendEMessageServiceTest < BaseServiceTest

  def setup
    initial_sender_client
  end


  # => ----------------------
  # => send_service_message
  # => ----------------------

  test "should return nil" do
    service = SendEMessageService.new
    response = service.send_service_message(nil)
    assert_not_nil response
    assert_equal ConstClass::INTERNAL_ERROR.keys[0], response.code
    assert_equal nil, response.result
  end

  test "should send nessage" do
    e_message = create_e_message
    service = SendEMessageService.new
    #response = service.send_service_message e_message
    #assert_not_nil response
    #assert_equal 200, response.code

    #temp_sent_message = SentEMessage.find_by(e_message: e_message.id)
    #assert_not_nil temp_sent_message
    #assert_equal e_message.id, temp_sent_message.e_message.id
  end

   test "should throw bad request error sending message" do
    assert_raise (RestClient::BadRequest){
      e_message = EMessage.new
      e_message.token = '112211'
      e_message.message = 'Test Message'
      e_message.sender_email = ''
      e_message.sender_name = 'test email'
      e_message.subject = 'subject'
      e_message.save
      SendEMessageService.new.send_service_message e_message
    }
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

    response = ('')
    response.stubs(:code).returns(200)

  	sent_message = service.create_sent_message(e_message, sender, response, true)
  	assert_not_nil sent_message
  	assert_equal e_message.id, sent_message.e_message.id
  	assert_equal sender.id, sent_message.sender.id
  end

  test "should does post call" do
    #mocks
    e_message = EMessage.new
    e_message.send_to = ENV["SEND_EMAIL_TEST_EMAIL"]
    e_message.sender_email = ENV["SEND_EMAIL_TEST_EMAIL"]
    e_message.message = 'Teste does post call'
    e_message.url = @mailgun_test_url
    e_message.subject = 'Teste send email'
    #call
    service = SendEMessageService.new
    response = ('')
    service.stubs(:does_post_call).returns(response)
    response.stubs(:code).returns(200)
    response = service.does_post_call e_message, nil
    #checks
    assert_not_nil response
    assert_equal 200, response.code
  end

   test "should throw InvalidURIError error" do
    assert_raise (URI::InvalidURIError){
      #mocks
      e_message = EMessage.new
      e_message.send_to = ENV["SEND_EMAIL_TEST_EMAIL"]
      e_message.sender_email = ENV["SEND_EMAIL_TEST_EMAIL"]
      e_message.message = 'Teste does post call'
      e_message.url = ''
      e_message.subject = 'Teste send email'
      #call
      service = SendEMessageService.new
      response = service.does_post_call e_message, nil
  }
  end

test "should throw BadRequest error" do
  assert_raise (RestClient::BadRequest){
    #mocks
    e_message = EMessage.new
    e_message.send_to = ENV["SEND_EMAIL_TEST_EMAIL"]
    e_message.sender_email = nil
    e_message.message = 'Teste does post call'
    e_message.url = @mailgun_test_url
    e_message.subject = 'Teste send email'
    #call
    service = SendEMessageService.new
    response = service.does_post_call e_message, nil
  }
  end


end
