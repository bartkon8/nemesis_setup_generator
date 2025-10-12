class CharacterSelector
  def self.call(variant:, count:)
    rel = CharacterVariant.includes(:character).where(variant:)
    items = rel.map do |cv|
      weight = cv.priority.to_i * (cv.character.try(:global_priority) || 1)
      [[cv.character.id, cv.character.name], weight]
    end
    picked = WeightedSelector.pick_many_without_replacement(items, count)
    ids = picked.map(&:first)
    by_id = Character.where(id: ids).index_by(&:id)
    ids.map { |id| by_id[id] }
  end
end
