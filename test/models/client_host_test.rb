require 'test_helper'

class ClientHostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should_save_client_host" do
 	client_host = ClientHost.new
 	assert !client_host.save
	assert !client_host.valid?

	client = Client.new
 	client.name = 'client'
 	client.token = '1233211123'
	client.save

 	client_host.client = client
 	assert !client_host.valid?
	assert !client_host.save

	client_host.host = 'localhost'
 	assert client_host.valid?
	assert client_host.save
  end
end
