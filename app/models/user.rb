class User < ApplicationRecord
    validates :name, {presence: true}
    validates :password, {presence: true,uniqueness: true}

    has_many :posts,  :dependent => :destroy
    has_many :likes,  :dependent => :destroy


    has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
    has_many :followings, through: :following_relationships
    has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
    has_many :followers, through: :follower_relationships


    
    has_many :messages
    has_many :entries

    def following?(other_user)
      following_relationships.find_by(following_id: other_user.id)
    end

    def follow!(other_user)
      following_relationships.create!(following_id: other_user.id)
    end

    def unfollow!(other_user)
      following_relationships.find_by(following_id: other_user.id).destroy
    end
end
