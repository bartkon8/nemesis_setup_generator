class Game < ApplicationRecord
  has_many :game_expansions, dependent: :destroy
  has_many :expansions, through: :game_expansions

  has_many :variants, dependent: :destroy
end
