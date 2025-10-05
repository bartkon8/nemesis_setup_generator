class CreateCharacterVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :character_variants do |t|
      t.references :character, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true
      t.integer :priority

      t.timestamps
    end
  end
end
