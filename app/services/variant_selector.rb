class VariantSelector
  def self.call
    items = Variant.all.map { |v| [v, v.priority.to_i] }
    WeightedSelector.pick_one(items)
  end
end
