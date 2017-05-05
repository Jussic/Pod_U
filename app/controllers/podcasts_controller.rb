class PodcastsController < ApplicationController
    before_action :find_podcast, only: [:show, :dashboard]
    before_action :find_episode, only: [:show, :dashboard]
    
    # this allows impression gem to track the page views 
    impressionist actions: [:show]

    def index
        @podcasts = Podcast.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    end

    def search
        if request.podcast?
    
          #pass the post into a get with the 'q' param
          redirect_to search_podcast_path(:q => params[:search][:query])
    
        elsif request.get?
        unless params[:q].blank?
    
            #Searchlogics title_like_all to search within titles in the Post model for any of the words in the query.
            #words in the string are split into an array by spaces
            search = Podcast.title_like_all(params[:q].to_s.split).descend_by_created_at
    
            #paginate the results
            @podcasts = search.paginate(:per_page => 25, :page => params[:page])
    
            #pass the query object to the view to let the user know what they searched for
            @query = params[:q]
        end
          #render the Post index.html.erb
          render 'index'
        end
    end
    
    
    def show 
        @podcast = Podcast.find params[:id] #-> id will have been sent by redirect_to @user
    end
    
    def dashboard
    end 

    private
    
    def find_episode
        @episodes = Episode.where(podcast_id: @podcast).order("created_at DESC").paginate(:page => params[:page], :per_page => 4)
    end
    
    def find_podcast 
        if params[:id].nil?
            @podcast = current_podcast
        else 
            @podcast = Podcast.find(params[:id])
        end 
    end
end
