class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by_id(params[:artist_id])
      if @artist 
        @songs = @artist.songs
      else
        flash[:no_artist] = "Artist not found"
        redirect_to artists_path
      end
    else
      @songs = Song.all
    end
  end

  def show
    @artist = Artist.find_by_id(params[:artist_id])
    if params[:id] && @artist
      @song = @artist.songs.find_by_id(params[:id])
      if !@song
        flash[:alert] = "Song not found"
        redirect_to artist_songs_path(@artist)
      end
    else
      @song = Song.find_by_id(params[:id])
    end
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

  # def set_artist
  #   @artist = Artist.find_by_id(params[:artist_id])
  # end

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

