class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to("/posts/index")
    else
      flash[:notice] = "投稿に失敗しました"
      render("posts/new")
    end
  end

  def search
    @posts = Post.search(params[:search])
    @post_search = params[:search]
  end


  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.sick_name = params[:sick_name]
    @post.period = params[:period]
    @post.initial_symptom = params[:initial_symptom]
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "更新しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def delete
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/")
  end

end



private

def post_params
  params.permit(:sick_name, :period, :content ,:name,:initial_symptom)
end
