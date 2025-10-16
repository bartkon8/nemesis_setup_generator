require "test_helper"

class CharacterVariantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character_variant = character_variants(:one)
  end

  test "should get index" do
    get character_variants_url
    assert_response :success
  end

  test "should get new" do
    get new_character_variant_url
    assert_response :success
  end

  test "should create character_variant" do
    assert_difference("CharacterVariant.count") do
      post character_variants_url, params: { character_variant: { character_id: @character_variant.character_id, priority: @character_variant.priority, variant_id: @character_variant.variant_id } }
    end

    assert_redirected_to character_variant_url(CharacterVariant.last)
  end

  test "should show character_variant" do
    get character_variant_url(@character_variant)
    assert_response :success
  end

  test "should get edit" do
    get edit_character_variant_url(@character_variant)
    assert_response :success
  end

  test "should update character_variant" do
    patch character_variant_url(@character_variant), params: { character_variant: { character_id: @character_variant.character_id, priority: @character_variant.priority, variant_id: @character_variant.variant_id } }
    assert_redirected_to character_variant_url(@character_variant)
  end

  test "should destroy character_variant" do
    assert_difference("CharacterVariant.count", -1) do
      delete character_variant_url(@character_variant)
    end

    assert_redirected_to character_variants_url
  end
end
