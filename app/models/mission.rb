class Mission < ActiveRecord::Base
    has_many :operations
    has_many :teams, through: :operations

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :description, presence: true
    validates :nemesis, presence: true

end