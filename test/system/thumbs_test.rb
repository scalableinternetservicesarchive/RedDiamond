require "application_system_test_case"

class ThumbsTest < ApplicationSystemTestCase
  setup do
    @thumb = thumbs(:one)
  end

  test "visiting the index" do
    visit thumbs_url
    assert_selector "h1", text: "Thumbs"
  end

  test "creating a Thumb" do
    visit thumbs_url
    click_on "New Thumb"

    fill_in "Thumbcount", with: @thumb.thumbcount
    fill_in "Thumber", with: @thumb.thumber
    fill_in "User", with: @thumb.user_id
    click_on "Create Thumb"

    assert_text "Thumb was successfully created"
    click_on "Back"
  end

  test "updating a Thumb" do
    visit thumbs_url
    click_on "Edit", match: :first

    fill_in "Thumbcount", with: @thumb.thumbcount
    fill_in "Thumber", with: @thumb.thumber
    fill_in "User", with: @thumb.user_id
    click_on "Update Thumb"

    assert_text "Thumb was successfully updated"
    click_on "Back"
  end

  test "destroying a Thumb" do
    visit thumbs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Thumb was successfully destroyed"
  end
end
