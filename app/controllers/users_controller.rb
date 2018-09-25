class UsersController < ApplicationController

  def index
    @users=User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image ="defalut_user.jpg"
    if @user.save
      session[:user_id] = @user.id
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
    @currentUserEntry=Entry.where(user_id: @current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == @current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @userRoom_id = u.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
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

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end


   private

  def user_params
    params.permit(:name, :password, :image)
  end

end
