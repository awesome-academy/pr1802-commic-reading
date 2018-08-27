class ComicsController < ApplicationController
  def index
    @category = Category.find_by_id params[:category_id]
    @comics = @category&.comics || Comic.all
  end

  def new
    @comic = Comic.new
  end

  def show
    @comic = Comic.find params[:id]
    @author = @comic.author
    @category = @comic.category_ids
  end

  def create
    @comic = current_user.comics.new comic_params
    if @comic.save
      flash[:success] = t '.success'
      redirect_to comics_path
    else
      flash[:danger] = t '.fail'
      redirect_to comics_path
    end
  end

  def edit
    @comic = Comic.find params[:id]
  end

  def update
    @comic = Comic.find params[:id]
    if @comic.update_attributes comic_params
      flash[:success] = t '.success'
      redirect_to comics_path
    else
      render :edit
    end
  end

  def destroy
    @comic = Comic.find params[:id]
    @comic.destroy
    flash[:success] = t '.success'
    redirect_to comics_path
  end

  private
  def comic_params
    params.require(:comic).permit :title, :content, :author_id, :picture, category_ids: []
  end
end
