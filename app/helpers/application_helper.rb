module ApplicationHelper
    def logged_in?
        !!current_user
    end
    
    # Tell me who is logged in
    def current_user
        @_current ||= User.find_by(id: session[:user_id])
    end
    
    def authorize!
        # A very simple authorization! Are you logged in? If not, let's get you started.
        redirect_to login_path if !logged_in?
    end
    
    def flash_message
        @_msg ||= flash[:message]
    end

    def superhero_starts_with(name_start)
        if name_start
            hero_search(URI::encode(name_start))
        else
            nil
        end
    end

    def create_superhero_from_api(name)
        create_superheros(hero_hash(URI::encode(name)))
        Superhero.last
    end

    

    private
    
        

        def hero_search(search)
            marvel_api_url = 'https://gateway.marvel.com/v1/public/'
            and_marvel_get_key = '&limit=100&ts=1&apikey=65ac18b7eb4747607961323d254cb29f&hash=5085cc4696b4ec1400b45b38663cc93e'
            marvel_char_name = 'characters?nameStartsWith='
            find_hero_string = marvel_api_url + marvel_char_name + search + and_marvel_get_key
            
            charJSON = JSON.parse(RestClient.get(find_hero_string))
            charJSON["data"]["results"].map do |char|
                char["name"]
            end
        end

        def hero_hash(name_url)
            marvel_api_url = 'https://gateway.marvel.com/v1/public/'
            and_marvel_get_key = '&limit=100&ts=1&apikey=65ac18b7eb4747607961323d254cb29f&hash=5085cc4696b4ec1400b45b38663cc93e'
            marvel_char_name = 'characters?name='
            find_hero_string = marvel_api_url + marvel_char_name + name_url + and_marvel_get_key
            RestClient.get(find_hero_string)
        end


        def create_superheros(char_data)
            charJSON = JSON.parse(char_data)
            charJSON["data"]["results"].each do |char| 
                Superhero.create( name: char["name"], description: char["description"], imgurl: char["thumbnail"]["path"] + "." + char["thumbnail"]["extension"] )
            end
        end

end
