class MakeVariantExpansionOptional < ActiveRecord::Migration[7.1]
  def change
    change_column_null :variants, :expansion_id, true
  end
end
