class ChapterAttachmentsController < ApplicationController
  before_action :admin_user, only: [:destroy, :edit, :update]
  
  def edit
    @chapter_attachment = ChapterAttachment.find params[:id]
  end

  def update
    @chapter_attachment = ChapterAttachment.find params[:id]
    chapter = @chapter_attachment.chapter
    comic = chapter.comic
    if @chapter_attachment.update_attributes chapter_attachment_params
      flash[:success] = t '.success'
      redirect_to comic_chapter_path comic, chapter
    else
      render :edit
    end
  end

  def destroy
    @chapter_attachment = ChapterAttachment.find params[:id]
    chapter = @chapter_attachment.chapter
    comic = chapter.comic
    @chapter_attachment.destroy
    flash[:success] = t '.success'
    redirect_to comic_chapter_path comic, chapter
  end

  private
  def chapter_attachment_params
    params.require(:chapter_attachment).permit :id, :chapter_id, :picture
  end
end
