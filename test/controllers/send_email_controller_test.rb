require 'test_helper'

class SendEmailControllerTest < ActionController::TestCase

  #MyClass.send(:public, :method_name)
  def setup
    @valid_params = {:token => '112211', :message => 'Test Message', :sender_email => 'teste@teste.com', :sender_name => 'test email', :subject => 'subject'}
  end


  def create_temp_client
    client = Client.new
    client.name = 'test'
    client.token = '112211'
    client.active = true
    #client.registration_date = DateTime.now
    client.host = 'localhost'
    return client
  end

  def create_temp_mailgun_sender
    sender = Sender.new
    sender.additional_data = ENV["MAILGUN_URL"] + "|" + ENV["MAILGUN_KEY"]
    sender.name = 'Mailgun'
    sender.active = true
    sender.sender_class = 'Mailgun'
    return sender
  end

  test "should return error 400" do
    post :send_email
    assert_response :bad_request
  end

  test "should return invalid payload" do
  	params = {:token => ''}
    post :send_email, params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
    assert_response :bad_request
    message = response.body
    assert_not_nil message
  	message = JSON.parse(message)
  	assert message.has_key?("message")
  	assert message.has_key?("subject")
  	assert message.has_key?("sender_email")
  	assert message.has_key?("sender_name")
  	assert message.has_key?("token")
  	assert_equal 'must have at least 10 words', message["message"][0]

  	params = {:token => '123', :message => 'Test Message', :sender_email => 'teste@teste.com'}

  	post :send_email, params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
    assert_response :bad_request
    message = response.body
    assert_not_nil message
  	message = JSON.parse(message)

  	assert !message.has_key?("message")
  	assert !message.has_key?("sender_email")
  	assert !message.has_key?("token")
	
  	assert message.has_key?("subject")
  	assert_equal 'Field Required', message["subject"][0]
  	assert message.has_key?("sender_name")
  	assert_equal 'Field Required', message["sender_name"][0]
  end

  test "should return invalid message content errors" do
  	message_content = 'Note that the default error messages are plural (e.g., "is too short (minimum is %{count} characters)"). For this reason, when :minimum is 1 you should provide a personalized message or use presence: true instead. When :in or :within have a lower limit of 1, you should either provide a personalized message or call presence prior to length.'
  	params = {:token => '123', :message => message_content, :sender_email => 'teste@teste.com'}

  	post :send_email, params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
    assert_response :bad_request
    message = response.body
    assert_not_nil message
  	message = JSON.parse(message)

  	assert message.has_key?("message")
  	assert_equal('must have at most 100 words', message['message'][0])
  	assert message.has_key?("subject")
  	assert !message.has_key?("sender_email")
  	assert message.has_key?("sender_name")
  	assert !message.has_key?("token")

  end

  test "should return invalid client error" do
    post :send_email, @valid_params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
    assert_response :bad_request
    message = response.body
    message = JSON.parse(message)
    assert message.has_key?("message")
    assert_equal ConstClass::INVALID_CLIENT.values[0], message['message']
    assert_equal ConstClass::INVALID_CLIENT.keys[0], message['code'].to_i
  end

  test "should return valid client" do
    create_temp_client.save
    @request.host = 'localhost'
    post :send_email, @valid_params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
    assert_response :ok
    message = response.body
    message = JSON.parse(message)    
    assert message.has_key?("message")
    assert_equal 'success', message['message'] 
    assert_equal ConstClass::SUCCESS.keys[0], message['code'].to_i
  end

  test "should save message" do
    #init temp
    create_temp_mailgun_sender.save    
    create_temp_client.save

    @request.host = 'localhost'
    post :send_email, @valid_params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
    assert_response :ok
    message = response.body
    message = JSON.parse(message)    
    assert message.has_key?("message")
    assert_equal 'success', message['message'] 
    assert_equal ConstClass::SUCCESS.keys[0], message['code'].to_i
 end

end