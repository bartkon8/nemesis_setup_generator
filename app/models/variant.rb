class Variant < ApplicationRecord
  belongs_to :game
  belongs_to :expansion, optional: true

  has_many :character_variants, dependent: :destroy
  has_many :characters, through: :character_variants
  has_many :setups, dependent: :destroy

  validates :priority, numericality: { greater_than_or_equal_to: 0 }
  validate :expansion_belongs_to_game

  def display_name
    expansion ? "#{game.name} – #{expansion.name}" : game.name
  end

  private
  def expansion_belongs_to_game
    return unless expansion
    errors.add(:expansion, "nie pasuje do tej gry") unless expansion.games.exists?(id: game_id)
  end
end
