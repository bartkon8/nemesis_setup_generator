class CreateVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :variants do |t|
      t.string :name
      t.references :game, null: false, foreign_key: true
      t.references :expansion, null: false, foreign_key: true
      t.integer :priority

      t.timestamps
    end
  end
end
