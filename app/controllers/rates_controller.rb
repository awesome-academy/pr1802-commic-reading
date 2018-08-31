class RatesController < ApplicationController
  before_action :find_rate, only: [:update]
  before_action :find_comic, only: [:create, :update]

  def create
    @rate = @comic.rates.build rate_params
    if @rate.save
      flash[:info] = t '.success'
      redirect_to comic_path @rate.comic.id
    else
      flash[:alert] = t '.fail'
      render "comics/show"
    end
  end

  def update
    if @rate.update_attributes rate_params
      flash[:success] = t '.success'
      redirect_to comic_path @rate.comic.id
    else
      flash[:alert] = t '.fail'
      render "comics/show"
    end
  end

  private
  def rate_params
    params.require(:rate).permit(:rate).merge user_id: current_user.id
  end

  def find_comic
    @comic = Comic.find_by id: params[:comic_id]
  end

  def find_rate
    @rate = Rate.find_by id: params[:id]
  end
end
