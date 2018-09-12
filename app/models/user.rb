class User < ApplicationRecord
    validates :name, {presence: true}
    validates :password, {presence: true,uniqueness: true}

    has_many :posts,  :dependent => :destroy
    has_many :likes,  :dependent => :destroy
end
