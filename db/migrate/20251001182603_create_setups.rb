class CreateSetups < ActiveRecord::Migration[7.1]
  def change
    create_table :setups do |t|
      t.references :variant, null: false, foreign_key: true
      t.integer :players
      t.jsonb :bag
      t.text :conditions

      t.timestamps
    end
  end
end
