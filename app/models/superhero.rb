class Superhero < ActiveRecord::Base
    has_many :recruits
    has_many :teams, through: :recruits
    has_many :operations, through: :teams
    has_many :missions, through: :operations

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :description, presence: true
    

    def create_superhero_from_api(name)
        create_superheros(hero_hash(URI::encode(name)))
    end

    def superhero_starts_with(name_start)
        hero_search(URI::encode(name_start))
    end

    private

    def hero_hash(name_url)
        and_marvel_get_key = '&ts=1&apikey=65ac18b7eb4747607961323d254cb29f&hash=5085cc4696b4ec1400b45b38663cc93e'
        marvel_api_url = 'https://gateway.marvel.com/v1/public/'
        marvel_char_name = 'characters?name='
        find_hero_string = marvel_api_url + marvel_char_name + name_url + and_marvel_get_key
        RestClient.get(find_hero_string)
    end

    def hero_search(search)
        and_marvel_get_key = '&limit=100&ts=1&apikey=65ac18b7eb4747607961323d254cb29f&hash=5085cc4696b4ec1400b45b38663cc93e'
        marvel_api_url = 'https://gateway.marvel.com/v1/public/'
        marvel_char_name = 'characters?nameStartsWith='
        find_hero_string = marvel_api_url + marvel_char_name + name_url + and_marvel_get_key
        
        charJSON = JSON.parse(RestClient.get(find_hero_string))
        charJSON["data"]["results"].map do |char|
            char["name"]
        end
    end
        
        

    def create_superheros(char_data)
        charJSON = JSON.parse(char_data)
        charJSON["data"]["results"].each do |char| 
            Superhero.create( name: char["name"], description: char["description"], imgurl: char["thumbnail"]["path"] + "." + char["thumbnail"]["extension"] )
        end
    end
end