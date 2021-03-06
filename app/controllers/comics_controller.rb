class ComicsController < ApplicationController
  before_action :admin_user, except: [:index, :new, :show]

  def index
    if params[:search]
      @comics = Comic.search params[:search]
    else
      @category = Category.find_by_id params[:category_id]
      @comics = @category&.comics || Comic.all
    end
    @comics = @comics.send params[:scope] if params[:scope]
  end

  def new
    @comic = Comic.new
  end

  def show
    @comic = Comic.find params[:id]
    @author = @comic.author
    @category = @comic.category_ids
    @chapters = @comic.chapters.title_asc
    return unless logged_in?
    @rate = current_user.rates.find_or_initialize_by comic_id: @comic.id
  end

  def create
    @comic = current_user.comics.new comic_params
    if @comic.save
      flash[:success] = t '.success'
      redirect_to @comic
    else
      flash[:danger] = t '.fail'
      render :new
    end
  end

  def edit
    @comic = Comic.find params[:id]
  end

  def update
    @comic = Comic.find params[:id]
    if @comic.update_attributes comic_params
      flash[:success] = t '.success'
      redirect_to comic_path
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
    params.require(:comic).permit :title,
      :content, :author_id, :picture, :search, :status, category_ids: []
  end
end
