require "test_helper"

class ReservableTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservable_time = reservable_times(:one)
  end

  test "should get index" do
    get reservable_times_url
    assert_response :success
  end

  test "should get new" do
    get new_reservable_time_url
    assert_response :success
  end

  test "should create reservable_time" do
    assert_difference("ReservableTime.count") do
      post reservable_times_url, params: { reservable_time: { minute: @reservable_time.minute } }
    end

    assert_redirected_to reservable_time_url(ReservableTime.last)
  end

  test "should show reservable_time" do
    get reservable_time_url(@reservable_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_reservable_time_url(@reservable_time)
    assert_response :success
  end

  test "should update reservable_time" do
    patch reservable_time_url(@reservable_time), params: { reservable_time: { minute: @reservable_time.minute } }
    assert_redirected_to reservable_time_url(@reservable_time)
  end

  test "should destroy reservable_time" do
    assert_difference("ReservableTime.count", -1) do
      delete reservable_time_url(@reservable_time)
    end

    assert_redirected_to reservable_times_url
  end
end
