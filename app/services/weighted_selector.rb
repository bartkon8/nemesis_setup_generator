class WeightedSelector
  def self.pick_one(weighted_items)
    pool = weighted_items.select { |_, w| w.to_i > 0 }
    sum  = pool.sum { |_, w| w }
    raise ArgumentError, "sum of weights is zero" if sum <= 0
    r = rand(0...sum)
    pool.each do |item, weight|
      return item if r < weight
      r -= weight
    end
  end

  def self.pick_many_without_replacement(weighted_items, count)
    chosen = []
    pool = weighted_items.dup
    count.times do
      break if pool.empty?
      picked = pick_one(pool)
      chosen << picked
      pool.reject! { |(item, _)| item == picked }
    end
    chosen
  end
end
