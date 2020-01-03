# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

spidermanHash = RestClient.get('https://gateway.marvel.com/v1/public/characters?name=Spider-Man&ts=1&apikey=65ac18b7eb4747607961323d254cb29f&hash=5085cc4696b4ec1400b45b38663cc93e')

def create_superheros(char_data)
    charJSON = JSON.parse(char_data)
    charJSON["data"]["results"].each do |char| 
        Superhero.create( name: char["name"], description: char["description"], imgurl: char["thumbnail"]["path"] + "." + char["thumbnail"]["extension"] )
    end
end


marvel_char_name_start = 'characters?nameStartsWith='

create_superheros(spidermanHash)

def hero_hash(name_url)
    and_marvel_get_key = '&ts=1&apikey=65ac18b7eb4747607961323d254cb29f&hash=5085cc4696b4ec1400b45b38663cc93e'
    marvel_api_url = 'https://gateway.marvel.com/v1/public/'
    marvel_char_name = 'characters?name='
    find_hero_string = marvel_api_url + marvel_char_name + name_url + and_marvel_get_key
    RestClient.get(find_hero_string)
end

# iron_fist = hero_hash(Iron%20Fist%20(Danny%20Rand))

black_widow = hero_hash('Black%20Widow')

create_superheros(black_widow)

def create_superhero_from_api(name_url)
    create_superheros(hero_hash(name_url))
end


avenger_array = []
avenger_array << Superhero.second
create_superhero_from_api('Iron%20Man')
create_superhero_from_api('Hulk')
create_superhero_from_api('Captain%20America')
create_superhero_from_api('Hawkeye%2FClint%20Barton%20(MAA)')
create_superhero_from_api('Thor')

avenger_array << Superhero.find_by(name: 'Iron Man')
avenger_array << Superhero.find_by(name: 'Hulk')
avenger_array << Superhero.find_by(name: 'Captain America')
avenger_array << Superhero.find_by(name: 'Hawkeye/Clint Barton (MAA)')
avenger_array << Superhero.find_by(name: 'Thor')

a = Team.create(name: "Avengers" )

def mass_recruit(hero_array, team)
    hero_array.each do |hero|
        r = Recruit.create(superhero: hero, team: team )
    end
end

mass_recruit(avenger_array, a)

defender_array = []
create_superhero_from_api('Iron%20Fist%20(Danny%20Rand)')
create_superhero_from_api('jessica%20jones')
create_superhero_from_api('daredevil')
create_superhero_from_api('luke%20cage')
defender_array << Superhero.find_by(name: 'Iron Fist (Danny Rand)')
defender_array << Superhero.find_by(name: 'Jessica Jones')
defender_array << Superhero.find_by(name: 'Daredevil')
defender_array << Superhero.find_by(name: 'Luke Cage')



d = Team.create(name: "Defenders" )

mass_recruit(defender_array, d)