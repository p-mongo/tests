require "application_system_test_case"

class LogosTest < ApplicationSystemTestCase
  setup do
    @logo = logos(:one)
  end

  test "visiting the index" do
    visit logos_url
    assert_selector "h1", text: "Logos"
  end

  test "creating a Logo" do
    visit logos_url
    click_on "New Logo"

    click_on "Create Logo"

    assert_text "Logo was successfully created"
    click_on "Back"
  end

  test "updating a Logo" do
    visit logos_url
    click_on "Edit", match: :first

    click_on "Update Logo"

    assert_text "Logo was successfully updated"
    click_on "Back"
  end

  test "destroying a Logo" do
    visit logos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Logo was successfully destroyed"
  end
end
