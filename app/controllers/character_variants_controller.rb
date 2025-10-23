class CharacterVariantsController < ApplicationController
  before_action :set_character_variant, only: %i[ show edit update destroy ]

  # GET /character_variants or /character_variants.json
  def index
    @character_variants = CharacterVariant.all
  end

  # GET /character_variants/1 or /character_variants/1.json
  def show
  end

  # GET /character_variants/new
  def new
    @character_variant = CharacterVariant.new
  end

  # GET /character_variants/1/edit
  def edit
  end

  # POST /character_variants or /character_variants.json
  def create
    @character_variant = CharacterVariant.new(character_variant_params)

    respond_to do |format|
      if @character_variant.save
        format.html { redirect_to @character_variant, notice: "Character variant was successfully created." }
        format.json { render :show, status: :created, location: @character_variant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @character_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /character_variants/1 or /character_variants/1.json
  def update
    respond_to do |format|
      if @character_variant.update(character_variant_params)
        format.html { redirect_to @character_variant, notice: "Character variant was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @character_variant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @character_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character_variants/1 or /character_variants/1.json
  def destroy
    @character_variant.destroy!

    respond_to do |format|
      format.html { redirect_to character_variants_path, notice: "Character variant was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_character_variant
      @character_variant = CharacterVariant.find(params[:id])
    end

    def character_variant_params
      params.require(:character_variant).permit(:character_id, :variant_id, :priority)
    end
end
