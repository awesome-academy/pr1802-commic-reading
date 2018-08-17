class ComicsController < ApplicationController
  def index
    @comics = if params[:category]
      Category.find(params[:category]).comics
    else
      Comic.all
    end
    @comic = Comic.new
    @author = @comic.author
  end

  def new
    @comic = Comic.new
  end

  def show
    @comic = Comic.find params[:id]
    @author = @comic.author
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
    params.require(:comic).permit :title, :content, :author_id, :picture
  end
end
