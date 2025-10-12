# app/controllers/setups_controller.rb
class SetupsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    player_count = params[:player_count].presence&.to_i || 4
    char_count   = params[:char_count].presence&.to_i || 6

    result = SetupSelector.new(player_count:, char_count:).call

    if result.characters.size < char_count
      render json: { error: "Za mało kompatybilnych postaci dla wybranego wariantu" },
             status: :unprocessable_entity
      return
    end

    render json: {
      variant: {
        id: result.variant.id,
        name: [result.variant.game&.name, result.variant.expansion&.name]
                .compact.join(" – ")
                .presence || result.variant.name
      },
      characters: result.characters.map { |c| { id: c.id, name: c.name } },
      setup: result.setup&.bag_json || {}
    }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
