class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, :dependent => :destroy
  has_many :comments,  :dependent => :destroy

  validates :sick_name, {presence: true}
  validates :period, {presence: true}
  validates :content, {presence: true}



  default_scope -> { order(created_at: :desc) }

  def self.search(search)
    if search
      Post.where(['sick_name LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end




end
