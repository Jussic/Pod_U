class SearchController < ApplicationController
  def index
    if jump = jump_target
      redirect_to jump
    else
      @results = Search.for(params[:keyword])
    end
  end

  private
    def jump_target
      Podcast.find_by(title: params[:keyword]) ||
      Podcast.find_by(description: params[:keyword])
    end
end
