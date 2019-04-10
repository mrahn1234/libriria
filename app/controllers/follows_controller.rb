class FollowsController < ApplicationController
  before_action :logged_in_user

  def create
    @type = params[:target_type]
    @id = params[:target_id]
    if @type == "Book"
      @target = Book.find(@id)
      current_user.follow_book(@target)
    else
      @target = Author.find(@id)
      current_user.follow_author(@target)
    end
    redirect_to @target
  end

  def destroy
    @follow = Follow.find params[:id]
  	@target = @follow.target
    if @target.class.to_s == "Book"

      current_user.unfollow_book(@target)  
    else
      current_user.unfollow_author(@target)
    end
    redirect_to @target
  end
end
