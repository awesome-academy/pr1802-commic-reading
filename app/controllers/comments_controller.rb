class CommentsController < ApplicationController
  before_action :find_comic
  before_action :find_chapter
  before_action :find_comment
  before_action :logged_in_user, only: :create
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def create
    @comment = @chapter.comments.build comment_params
      .merge(user_id: current_user.id)
      if @comment.save
        respond_to do |format|
          format.html do
            redirect_to comic_chapter_path(@comic, @chapter)
            flash[:success] = t '.success'
          end
          format.js
        end
      else
        respond_to do |format|
          format.html do
            redirect_to comic_chapter_path(@comic, @chapter)
            flash[:danger] = t '.failed'
          end
          format.js
        end
      end
  end

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      flash[:success] = t '.success'
      redirect_to comic_chapter_path @comic, @chapter
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = t '.success'
    redirect_to comic_chapter_path @comic, @chapter
  end

  def show
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def find_comic
    @comic = Comic.find_by id: params[:comic_id]
  end

  def find_chapter
    @chapter = Chapter.find_by id: params[:chapter_id]
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
  end

  def correct_user
    unless (@comment.user == current_user) || current_user.admin?
      redirect_to comic_chapter_path 
    end
  end
end
