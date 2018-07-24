require 'test_helper'

class GoogleSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get redirect" do
    get google_sessions_redirect_url
    assert_response :success
  end

end
