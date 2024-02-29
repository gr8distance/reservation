require "test_helper"

class ReserveControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get reserve_new_url
    assert_response :success
  end
end
