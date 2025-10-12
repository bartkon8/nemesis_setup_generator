class AddFieldsToSetups < ActiveRecord::Migration[7.1]
  def change
    add_column :setups, :player_count, :integer, null: false, default: 4
    add_column :setups, :bag_json, :jsonb, null: false, default: {}

    add_index :setups, [:variant_id, :player_count], unique: true
  end
end
