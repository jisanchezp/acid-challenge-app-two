require 'test_helper'

class Rest::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get verify" do
    get rest_sessions_verify_url
    assert_response :success
  end

end
