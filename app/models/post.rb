class Post < ApplicationRecord
  belongs_to :user

  def self.search(search)
    if search
      Post.where(['sick_name LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end

end
