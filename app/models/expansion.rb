class Expansion < ApplicationRecord
  has_many :game_expansions, dependent: :destroy
  has_many :games, through: :game_expansions

  has_many :variants, dependent: :nullify
  validates :name, presence: true
end
