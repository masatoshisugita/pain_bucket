class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image ="defalut_user.jpg"
    if @user.save
      flash[:notice] = "登録しました"
      redirect_to("/")
    else
      flash[:notice] = "登録に失敗しました"
      render("pages/index")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.all
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.password = params[:password]
    @user.image = "#{@user.id}.jpg"
    image = params[:image]
    File.binwrite("public/#{@user.image}",image.read)

    if @user.save
      flash[:notice] = "変更しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name],password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインに成功しました"
      redirect_to("/")
    else
      flash.now[:notice] = "ログインに失敗しました"
      render("pages/index")
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end





   private

  def user_params
    params.permit(:name, :password, :image)
  end

end
