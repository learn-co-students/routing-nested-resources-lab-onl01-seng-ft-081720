class SongsController < ApplicationController
  def index
    params.permit(:artist_id)
    if params[:artist_id]
      if Artist.where(id: params[:artist_id]).empty?
        flash[:notice] = "Artist not found"
        redirect_to artists_path
      else 
        @songs = Artist.find(params[:artist_id]).songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    # binding.pry
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = Song.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else 
      @song = Song.find(params[:id])
    end







    # params.permit(:id, :artist_id)
    # @song = Song.where(id: params[:id])
    # if params[:artist_id]
    #   @artist = Artist.where(id: params[:artist_id])
    #   if @song.empty? && @artist.empty?
    #       flash[:alert] = "Song not found"
    #   elsif @song.empty?
    #       flash[:alert] = "Song not found"
    #       redirect_to artist_songs_path(params[:artist_id])
    #   else
    #     @song
    #   end
    # else
    #   @song
    # end
    
    # binding.pry
    
    # @song = Song.where(artist_id: params[:id])
    # @artist = Artist.where(id: params[:artist_id])
    # # binding.pry
    # if @song.empty? && @artist.empty?
    #   flash[:alert] = "Song not found"
    # elsif @song.empty?
    #   flash[:alert] = "Song not found"
    #   redirect_to artist_songs_path(params[:artist_id])
    # else
    #   @song
    # end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

