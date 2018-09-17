class StaticPagesController < ApplicationController
  def home
    @comics = Comic.all
  end
end
