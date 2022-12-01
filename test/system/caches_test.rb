require "application_system_test_case"

class CachesTest < ApplicationSystemTestCase
  setup do
    @cach = caches(:one)
  end

  test "visiting the index" do
    visit caches_url
    assert_selector "h1", text: "Caches"
  end

  test "should create cach" do
    visit caches_url
    click_on "New cach"

    click_on "Create Cach"

    assert_text "Cach was successfully created"
    click_on "Back"
  end

  test "should update Cach" do
    visit cach_url(@cach)
    click_on "Edit this cach", match: :first

    click_on "Update Cach"

    assert_text "Cach was successfully updated"
    click_on "Back"
  end

  test "should destroy Cach" do
    visit cach_url(@cach)
    click_on "Destroy this cach", match: :first

    assert_text "Cach was successfully destroyed"
  end
end
