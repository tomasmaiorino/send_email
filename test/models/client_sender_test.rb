require 'test_helper'

class ClientSenderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create a client sender" do

    client_sender = ClientSender.new
    assert !client_sender.valid?
    assert !client_sender.save

    client = Client.new
   	client.name = 'client'
  	client.token = '1233211123'
    assert client.save

    client_sender.client = client
    assert !client_sender.valid?
    assert !client_sender.save

    sender = Sender.new
   	sender.name = 'test'
  	sender.send_to = 'user@contact.com'
    assert sender.save

    client_sender.sender = sender
    assert client_sender.valid?
    assert client_sender.save

  end

end
