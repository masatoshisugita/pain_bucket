class PagesController < ApplicationController
  def index
    @post = Post.where(['sick_name LIKE ?', "%#{params[:sick_name]}%"])
    @post_name = params[:sick_name]
  end

  def about
  end
end
