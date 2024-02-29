require "application_system_test_case"

class ReservableTimesTest < ApplicationSystemTestCase
  setup do
    @reservable_time = reservable_times(:one)
  end

  test "visiting the index" do
    visit reservable_times_url
    assert_selector "h1", text: "Reservable times"
  end

  test "should create reservable time" do
    visit reservable_times_url
    click_on "New reservable time"

    fill_in "Minute", with: @reservable_time.minute
    click_on "Create Reservable time"

    assert_text "Reservable time was successfully created"
    click_on "Back"
  end

  test "should update Reservable time" do
    visit reservable_time_url(@reservable_time)
    click_on "Edit this reservable time", match: :first

    fill_in "Minute", with: @reservable_time.minute
    click_on "Update Reservable time"

    assert_text "Reservable time was successfully updated"
    click_on "Back"
  end

  test "should destroy Reservable time" do
    visit reservable_time_url(@reservable_time)
    click_on "Destroy this reservable time", match: :first

    assert_text "Reservable time was successfully destroyed"
  end
end
