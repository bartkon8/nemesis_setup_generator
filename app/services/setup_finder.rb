class SetupFinder
  def self.call(variant:, player_count:)
    Setup.find_by(variant:, player_count:) || Setup.find_by(variant:, player_count: 4)
  end
end
