# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# db/seeds.rb

puts "Czyścimy…"
CharacterVariant.delete_all
Setup.delete_all
Character.delete_all
Variant.delete_all
GameExpansion.delete_all
Expansion.delete_all
Game.delete_all

puts "Gry…"
nemesis  = Game.create!(name: "Nemesis")
lockdown = Game.create!(name: "Nemesis Lockdown")

puts "Dodatki…"
koszmary = Expansion.create!(name: "Koszmary")
karnomorfy = Expansion.create!(name: "Karnomorfy")

puts "Powiązania dodatek–gra (wiele-do-wielu)…"
GameExpansion.create!(game: nemesis,  expansion: koszmary)
GameExpansion.create!(game: nemesis,  expansion: karnomorfy)
GameExpansion.create!(game: lockdown, expansion: koszmary)
GameExpansion.create!(game: lockdown, expansion: karnomorfy)

puts "Warianty (gra + opcjonalnie dodatek)…"
v1 = Variant.create!(name: "Koszmary",              game: nemesis,  expansion: koszmary, priority: 2)
v2 = Variant.create!(name: "Lockdown Karnomorfy",   game: lockdown, expansion: karnomorfy, priority: 1)
v3 = Variant.create!(name: "Lockdown Koszmary",     game: lockdown, expansion: koszmary,  priority: 1)
v4 = Variant.create!(name: "Nemesis Classic",       game: nemesis,  priority: 1) # bez dodatku
v5 = Variant.create!(name: "Lockdown",              game: lockdown, priority: 1)

puts "Tworzenie postaci..."
chars = {
  "Żołnierz" => Character.find_or_create_by!(name: "Żołnierz"),
  "Zwiadowca" => Character.find_or_create_by!(name: "Zwiadowca"),
  "Mechanik"  => Character.find_or_create_by!(name: "Mechanik"),
  "Pilot"     => Character.find_or_create_by!(name: "Pilot"),
  "Android"   => Character.find_or_create_by!(name: "Android"),
  "Medyk"     => Character.find_or_create_by!(name: "Medyk"),
  "Naukowiec" => Character.find_or_create_by!(name: "Naukowiec"),
  "Łowca"     => Character.find_or_create_by!(name: "Łowca")
}

puts "Powiązania postać–wariant…"
# Nemesis (podstawka)
[v4].each do |variant|
  %w[Żołnierz Zwiadowca Mechanik Android Naukowiec].each do |name|
    CharacterVariant.create!(character: chars[name], variant: variant, priority: 2)
  end
end

# Nemesis + Koszmary
[v1].each do |variant|
  %w[Żołnierz Zwiadowca Mechanik Medyk Łowca].each do |name|
    CharacterVariant.create!(character: chars[name], variant: variant, priority: 2)
  end
end

# Lockdown (podstawka)
[v5].each do |variant|
  %w[Żołnierz Pilot Naukowiec Łowca].each do |name|
    CharacterVariant.create!(character: chars[name], variant: variant, priority: 2)
  end
end

# Lockdown + Karnomorfy
[v2].each do |variant|
  %w[Pilot Medyk Łowca Zwiadowca Mechanik].each do |name|
    CharacterVariant.create!(character: chars[name], variant: variant, priority: 2)
  end
end

puts "Setups…"
Setup.create!(variant: v1, player_count: 4, bag_json: { "intruder"=>4, "larva"=>3, "adult"=>5, "queen"=>1 })
Setup.create!(variant: v2, player_count: 4, bag_json: { "karnomorf"=>6, "metabolit"=>2, "król"=>1 })
Setup.create!(variant: v4, player_count: 4, bag_json: { "intruder"=>5, "larva"=>2, "adult"=>4, "queen"=>1 })

puts "OK ✅"

