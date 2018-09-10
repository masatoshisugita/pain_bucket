class Post < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  def self.search(search)
    if search
      Post.where(['sick_name LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end

end
