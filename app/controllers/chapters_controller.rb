class ChaptersController < ApplicationController
  before_action :find_comic
  before_action :find_chapter
  before_action :admin_user, except: [:index, :new, :show]
 
  def index
    @chapters = Chapter.all
  end

  def show
    @chapter_attachments = @chapter.chapter_attachments.all
  end

  def new
    @chapter = Chapter.new
    @chapter_attachments = @chapter.chapter_attachments.build
  end

  def create
    @chapter = current_user.chapters.build chapter_params.merge(comic_id: @comic.id)
    if @chapter.save
      params[:chapter_attachments][:picture].each do |a|
        @chapter_attachment = @chapter.chapter_attachments.create! picture: a
      end
      flash[:success] = t '.success'
      redirect_to comic_chapter_path @comic, @chapter
    else
      flash[:danger] = t '.fail'
      render :new
    end
  end

  def edit
  end

  def update
    if @chapter.update_attributes chapter_params
      flash[:success] = t '.success'
      redirect_to comic_chapter_path @comic, @chapter
    else
      flash[:danger] = t '.fail'
      render :edit
    end
  end

  def destroy
    @chapter.destroy
    flash[:success] = t '.success'
    redirect_to comic_path @comic
  end

  private
  def chapter_params
    params.require(:chapter).permit :title,
      chapter_attachments_attributes: [:id, :chapter_id, :picture]
  end

  def find_comic
    @comic = Comic.find_by id: params[:comic_id]
  end

  def find_chapter
    @chapter = Chapter.find_by id: params[:id]
  end
end
