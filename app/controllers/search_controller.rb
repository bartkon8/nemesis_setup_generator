class SearchController < ApplicationController
  def index
    q = params[:q].to_s.strip
    return unless q.present?

    @variants   = Variant.includes(:game, :expansion).where("variants.name ILIKE ?", "%#{q}%")
    @characters = Character.where("name ILIKE ?", "%#{q}%")
    @games      = Game.where("name ILIKE ?", "%#{q}%")
    @expansions = Expansion.where("name ILIKE ?", "%#{q}%")
  end
end
