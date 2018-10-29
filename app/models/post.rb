class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, :dependent => :destroy
  has_many :comments,  :dependent => :destroy

  validates :sick_name, {presence: true}
  validates :initial_symptom, {presence: true}
  validates :content, {presence: true}



  default_scope -> { order(created_at: :desc) }

  def self.reference(check)
    if check
      Post.where(['sick_name LIKE ?', "%#{check}%"])
    else
      Post.all
    end
  end




end
