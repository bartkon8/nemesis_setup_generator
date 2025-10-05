class CreateGameExpansions < ActiveRecord::Migration[7.1]
  def change
    create_table :game_expansions do |t|
      t.references :game, null: false, foreign_key: true
      t.references :expansion, null: false, foreign_key: true

      t.timestamps
    end
    add_index :game_expansions, [:game_id, :expansion_id], unique: true
  end
end
