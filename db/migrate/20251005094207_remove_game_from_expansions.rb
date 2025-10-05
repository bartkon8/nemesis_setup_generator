class RemoveGameFromExpansions < ActiveRecord::Migration[7.1]
  def change
    remove_reference :expansions, :game, null: false, foreign_key: true
  end
end
