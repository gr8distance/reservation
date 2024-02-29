require "application_system_test_case"

class BusinessHoursTest < ApplicationSystemTestCase
  setup do
    @business_hour = business_hours(:one)
  end

  test "visiting the index" do
    visit business_hours_url
    assert_selector "h1", text: "Business hours"
  end

  test "should create business hour" do
    visit business_hours_url
    click_on "New business hour"

    fill_in "End at", with: @business_hour.end_at
    fill_in "Start at", with: @business_hour.start_at
    click_on "Create Business hour"

    assert_text "Business hour was successfully created"
    click_on "Back"
  end

  test "should update Business hour" do
    visit business_hour_url(@business_hour)
    click_on "Edit this business hour", match: :first

    fill_in "End at", with: @business_hour.end_at
    fill_in "Start at", with: @business_hour.start_at
    click_on "Update Business hour"

    assert_text "Business hour was successfully updated"
    click_on "Back"
  end

  test "should destroy Business hour" do
    visit business_hour_url(@business_hour)
    click_on "Destroy this business hour", match: :first

    assert_text "Business hour was successfully destroyed"
  end
end
