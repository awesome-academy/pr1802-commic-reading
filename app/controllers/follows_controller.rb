class FollowsController < ApplicationController
  def create
    comic = Comic.find params[:follow][:comic_id]
    current_user.follow comic
    redirect_to comic
  end

  def destroy
    follow = current_user.follows.find params[:id]
    comic = follow.comic
    follow.destroy
    redirect_to comic
  end

  def index
    @user = current_user
    @comics = @user.followed_comics
    render 'users/show_follows'
  end
end
