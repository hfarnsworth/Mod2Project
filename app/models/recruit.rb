class Recruit < ActiveRecord::Base
    belongs_to :team
    belongs_to :superhero
end