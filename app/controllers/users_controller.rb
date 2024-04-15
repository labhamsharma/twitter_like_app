class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :follow, :unfollow]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @followers_count = @user.followers.count
    @following_count = @user.following.count
  end

  def follow
    if current_user.follow(@user)
      redirect_to @user, notice: "You are now following #{@user.username}"
    else
      redirect_to @user, alert: "Unable to follow user"
    end
  end

  def unfollow
    if current_user.unfollow(@user)
      redirect_to @user, notice: "You have unfollowed #{@user.username}"
    else
      redirect_to @user, alert: "Unable to unfollow user"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
