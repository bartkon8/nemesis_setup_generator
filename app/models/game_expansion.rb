class GameExpansion < ApplicationRecord
  belongs_to :game
  belongs_to :expansion

  validates :game_id, uniqueness: { scope: :expansion_id }
end
