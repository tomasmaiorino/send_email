require 'test_helper'

class SendEMessageServiceTest < ActionController::TestCase

  test "should return nil" do
    service = SendEMessageService.new
    response = service.send_message(nil)
    assert_not_nil response
    assert_equal ConstClass::INTERNAL_ERROR.keys[0], response.code
    assert_equal nil, response.result 
  end

end