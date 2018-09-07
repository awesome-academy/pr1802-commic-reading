class AuthorsController < ApplicationController
  before_action :admin_user, except: [:index, :new, :show]

  def show
    @author = Author.find params[:id]
    @comics = @author.comics
  end

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t '.success'
      redirect_to authors_path
    else
      flash[:danger] = t '.fail'
      redirect_to authors_path
    end
  end

  def edit
    @author = Author.find params[:id]
  end

  def update
    @author = Author.find params[:id]
    if @author.update_attributes author_params
      flash[:success] = t '.success'
      redirect_to authors_path
    else
      render :edit
    end
  end

  def destroy
    @author = Author.find params[:id]
    @author.destroy
    flash[:success] = t '.success'
    redirect_to authors_path
  end

  private
  def set_author
    if params[:id].present?
      @author = Author.find params[:id]
    else
      @author = Author.new
    end
  end

  def author_params
    params.require(:author).permit :name
  end
end
