class ComicsController < ApplicationController
  before_action :admin_user, only: [:create, :destroy, :edit, :update]

  def index
    if params[:search]
      @comics = Comic.search params[:search]
    else
      @category = Category.find_by_id params[:category_id]
      @comics = @category&.comics || Comic.all
    end
    @comics = @comics.rate_dsc
  end

  def new
    @comic = Comic.new
  end

  def show
    @comic = Comic.find params[:id]
    @author = @comic.author
    @category = @comic.category_ids
    return unless logged_in?
    @rate = current_user.rates.find_or_initialize_by comic_id: @comic.id
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
    params.require(:comic).permit :title, :content, :author_id, :picture, :search, category_ids: []
  end
end
