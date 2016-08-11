require 'test_helper'

class ClientTest < ActiveSupport::TestCase

test "should_save_client" do
 	client = Client.new
 	assert !client.save
	assert !client.valid?

 	client.name = 'client'
 	assert !client.valid?
	assert !client.save

	client.token = '1233211123'
 	assert !client.valid?
	assert !client.save

	client.host = 'localhost'
 	assert client.valid?
	assert client.save
 end

end
