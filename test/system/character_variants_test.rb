require "application_system_test_case"

class CharacterVariantsTest < ApplicationSystemTestCase
  setup do
    @character_variant = character_variants(:one)
  end

  test "visiting the index" do
    visit character_variants_url
    assert_selector "h1", text: "Character variants"
  end

  test "should create character variant" do
    visit character_variants_url
    click_on "New character variant"

    fill_in "Character", with: @character_variant.character_id
    fill_in "Priority", with: @character_variant.priority
    fill_in "Variant", with: @character_variant.variant_id
    click_on "Create Character variant"

    assert_text "Character variant was successfully created"
    click_on "Back"
  end

  test "should update Character variant" do
    visit character_variant_url(@character_variant)
    click_on "Edit this character variant", match: :first

    fill_in "Character", with: @character_variant.character_id
    fill_in "Priority", with: @character_variant.priority
    fill_in "Variant", with: @character_variant.variant_id
    click_on "Update Character variant"

    assert_text "Character variant was successfully updated"
    click_on "Back"
  end

  test "should destroy Character variant" do
    visit character_variant_url(@character_variant)
    accept_confirm { click_on "Destroy this character variant", match: :first }

    assert_text "Character variant was successfully destroyed"
  end
end
