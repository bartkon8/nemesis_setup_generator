# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_10_05_105703) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_variants", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "variant_id", null: false
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_variants_on_character_id"
    t.index ["variant_id"], name: "index_character_variants_on_variant_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "global_priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expansions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_expansions", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "expansion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expansion_id"], name: "index_game_expansions_on_expansion_id"
    t.index ["game_id", "expansion_id"], name: "index_game_expansions_on_game_id_and_expansion_id", unique: true
    t.index ["game_id"], name: "index_game_expansions_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setups", force: :cascade do |t|
    t.bigint "variant_id", null: false
    t.integer "players"
    t.jsonb "bag"
    t.text "conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_count", default: 4, null: false
    t.jsonb "bag_json", default: {}, null: false
    t.index ["variant_id", "player_count"], name: "index_setups_on_variant_id_and_player_count", unique: true
    t.index ["variant_id"], name: "index_setups_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "name"
    t.bigint "game_id", null: false
    t.bigint "expansion_id"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expansion_id"], name: "index_variants_on_expansion_id"
    t.index ["game_id"], name: "index_variants_on_game_id"
  end

  add_foreign_key "character_variants", "characters"
  add_foreign_key "character_variants", "variants"
  add_foreign_key "game_expansions", "expansions"
  add_foreign_key "game_expansions", "games"
  add_foreign_key "setups", "variants"
  add_foreign_key "variants", "expansions"
  add_foreign_key "variants", "games"
end
