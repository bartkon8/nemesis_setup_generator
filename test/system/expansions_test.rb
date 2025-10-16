require "application_system_test_case"

class ExpansionsTest < ApplicationSystemTestCase
  setup do
    @expansion = expansions(:one)
  end

  test "visiting the index" do
    visit expansions_url
    assert_selector "h1", text: "Expansions"
  end

  test "should create expansion" do
    visit expansions_url
    click_on "New expansion"

    fill_in "Name", with: @expansion.name
    click_on "Create Expansion"

    assert_text "Expansion was successfully created"
    click_on "Back"
  end

  test "should update Expansion" do
    visit expansion_url(@expansion)
    click_on "Edit this expansion", match: :first

    fill_in "Name", with: @expansion.name
    click_on "Update Expansion"

    assert_text "Expansion was successfully updated"
    click_on "Back"
  end

  test "should destroy Expansion" do
    visit expansion_url(@expansion)
    accept_confirm { click_on "Destroy this expansion", match: :first }

    assert_text "Expansion was successfully destroyed"
  end
end
