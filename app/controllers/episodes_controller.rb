class EpisodesController < ApplicationController
    before_action :authenticate_podcast!,  except: [:show],  only: [:update]
    before_filter :require_permission, only: [:update, :edit] 
    before_action :find_podcast
    before_action :find_episode, only: [:show, :edit, :update, :destroy]
    
    impressionist actions: [:show]
    
    def new 
        @episode = @podcast.episodes.new
    end
    
    # Nested route define both pod and ep and get the ids. 
    def create 
        @episode = @podcast.episodes.new episode_params
        if @episode.save
            redirect_to podcast_episode_path(@podcast, @episode)
        else 
            render 'new'
        end
    end
    
    def show
        @episodes = Episode.where(podcast_id: @podcast).order("created_at DESC").reject { |e| e.id == @episode.id}
    end
            
    def edit 
        
    end 

    
    def update 
        if @episode.update episode_params
        redirect_to podcast_episode_path(@podcast, @episode), notice: "Episode was successfully updated!"
        else 
        render 'edit'
        end 
    end
    
    def destroy 
    @episode.destroy
    redirect_to root_path
    end
    
    
    private
    
    # This allows the various features
    
    def episode_params
        params.require(:episode).permit(:title, :description, :episode_thumbnail, :mp3)
    end
    
    def find_podcast
        @podcast = Podcast.find(params[:podcast_id])
    end

    def find_episode
        @episode = Episode.find(params[:id])
    end
    
    def require_permission 
        @podcast = Podcast.find(params[:podcast_id])
        if current_podcast != @podcast
            redirect_to root_path, notice: "Sorry, you are not allowed to view that page"
        end
    end
end
