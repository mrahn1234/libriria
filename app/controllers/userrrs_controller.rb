class UsersController < ApplicationController

	before_action :find_user , only: [:show, :edit, :update, :destroy]

  def index
    @q = User.ransack(params[:q]) 
   	@users = @q.result.order("created_at DESC").page(params[:page])
    respond_to do |format|
        format.html
        format.xls{send_data @users.to_csv(col_sep: "\t")}
      end
  end

  def new
    @user = User.new 
  end

  def edit; end

  def show
    @user = User.find(params[:id]) 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # hand a successful saves
      log_in @user
      flash[:success] = "Welcome to VLC Library!!!!"
      redirect_to @user
    else
      render 'new'
    end
  end
  #  edit profile of user
  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(user_params)
  #     flash[:success] = "User updated"
  #     redirect_to user_path(@user.id)
  #   else 
  #     render 'edit'
  #   end   
  # end
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
        format.js
    end
    # flash[:success] = "User delected"
    # redirect_to users_url
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page params[:page]
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page params[:page]
    render 'show_follow' 
  end

  def followingbook
    @title = "Following Books"
    @user = User.find(params[:id])
    @books = @user.following_books.paginate(page: params[:page])
    render 'show_follow_book'
  end
  
  def followingauthor
    @title = "Following Authors"
    @user = User.find(params[:id])
    @authors = @user.following_authors.paginate(page: params[:page])
    render 'show_follow_author'
  end
  def likebook
    @title = "Like Books"
    @user = User.find(params[:id])
    @books = @user.liked_books.paginate(page: params[:page])
    render 'show_like_book'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confrimation) 
    end

    def admin_user
       redirect_to(root_url) unless current_user.role=1
    end
    
end