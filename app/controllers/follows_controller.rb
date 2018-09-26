class FollowsController < ApplicationController
  def create
    @comic = Comic.find params[:follow][:comic_id]
    current_user.follow @comic
    respond_to do |format|
      format.html{redirect_to @comic}
      format.js
    end
  end

  def destroy
    follow = current_user.follows.find params[:id]
    @comic = follow.comic
    follow.destroy
    respond_to do |format|
      format.html{redirect_to @comic}
      format.js
    end
  end

  def index
    @user = current_user
    @comics = @user.followed_comics
    render 'users/followed_comics'
  end
end
