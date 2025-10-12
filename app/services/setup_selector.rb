class SetupSelector
  Result = Struct.new(:variant, :characters, :setup, keyword_init: true)

  def initialize(player_count: 4, char_count: 6)
    @player_count = player_count
    @char_count   = char_count
  end

  def call
    variant = VariantSelector.call
    chars   = CharacterSelector.call(variant:, count: @char_count)
    setup   = SetupFinder.call(variant:, player_count: @player_count)
    Result.new(variant:, characters: chars, setup:)
  end
end
