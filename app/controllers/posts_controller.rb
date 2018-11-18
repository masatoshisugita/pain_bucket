class PostsController < ApplicationController
  before_action :authenticate_user
   PER = 3

  def index
    @posts = Post.page(params[:page]).per(PER)
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
    @posts = Post.reference(params[:search]).page(params[:page]).per(3)
    @post_search = params[:search]
  end

  def search_symptom
    @posts = Post.search_symptom(params[:symptom]).page(params[:page]).per(3)
    @post_search_symptom = params[:symptom]

  end

  def show
    @post = Post.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @post.comments
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





private

  def post_params
    params.permit(:sick_name, :period, :content ,:name,:initial_symptom)
  end

end
