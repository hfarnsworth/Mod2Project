class Superhero < ActiveRecord::Base
    has_many :recruits
    has_many :teams, through: :recruits
    has_many :operations, through: :teams
    has_many :missions, through: :operations

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :description, presence: true

    

end