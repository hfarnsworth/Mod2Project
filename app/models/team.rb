class Team < ActiveRecord::Base
    has_many :recruits
    has_many :superheros, through: :recruits
    has_many :operations
    has_many :missions, through: :operations

    validates :name, presence: true
end