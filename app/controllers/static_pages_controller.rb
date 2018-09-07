class StaticPagesController < ApplicationController
  def home
    @comics = Comic.rate_dsc
  end
end
