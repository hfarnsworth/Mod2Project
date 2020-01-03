class User < ActiveRecord::Base
    has_secure_password

    validates :name, uniqueness: true
    validates :name, presence: true
end