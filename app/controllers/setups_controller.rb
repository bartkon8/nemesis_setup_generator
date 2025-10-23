# app/controllers/setups_controller.rb
class SetupsController < ApplicationController
  before_action :set_setup, only: [:show, :edit, :update, :destroy]
  skip_forgery_protection only: :create

  # ===== CRUD (HTML) =====
  def index
    @setups = Setup.includes(variant: [:game, :expansion]).order(created_at: :desc)
  end

  def show; end

  def new
    @setup = Setup.new(player_count: 4)
  end

  def edit; end

  # jedna akcja dla HTML i API JSON
  def create
    return render_generator_json if json_api_request?  # <<< kończymy akcję dla API

    # ---- gałąź HTML CRUD ----
    @setup = Setup.new(setup_params)
    if @setup.save
      redirect_to @setup, notice: "Setup utworzony."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @setup.update(setup_params)
      redirect_to @setup, notice: "Setup zaktualizowany."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @setup.destroy
    redirect_to setups_path, notice: "Setup usunięty."
  end

  private

  def json_api_request?
    request.format.json? || params.key?(:player_count) || params.key?(:char_count)
  end

  # -------- API JSON (generator) --------
  def render_generator_json
    pc = params[:player_count].to_i
    cc = params[:char_count].to_i
    pc = 4 if pc <= 0
    cc = 6 if cc <= 0

    # 1) WALIDACJE WEJŚCIA – ZANIM URUCHOMIMY SELEKTOR
    if pc > cc
      render json: { error: "Liczba graczy nie może być większa niż liczba postaci" },
             status: :unprocessable_content
      return
    end

    # 2) LOSOWANIE
    result = SetupSelector.new(player_count: pc, char_count: cc).call

    # 3) WALIDACJE PULI
    if result.characters.size < cc
      render json: { error: "Za mało kompatybilnych postaci dla wybranego wariantu" },
             status: :unprocessable_content
      return
    end

    # 4) OK
    render json: {
      variant: {
        id:   result.variant.id,
        name: [result.variant.game&.name, result.variant.expansion&.name]
                .compact.join(" – ").presence || result.variant.name
      },
      characters: result.characters.map { |c| { id: c.id, name: c.name } },
      setup: result.setup&.bag_json || {}
    }
    return
  rescue => e
    Rails.logger.error(e.full_message)
    render json: { error: e.message }, status: :internal_server_error
    return
  end

  # -------- CRUD helpers --------
  def set_setup
    @setup = Setup.find(params[:id])
  end

  def setup_params
    params.require(:setup).permit(:variant_id, :player_count, :conditions, bag_json: {})
  end
end
