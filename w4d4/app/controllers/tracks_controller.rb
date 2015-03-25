class TracksController < ApplicationController

  before_action :require_login_to_view

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    album = Album.find(@track.album)
    if @track.destroy
      #message
      redirect_to album_url(album)
    else
      #error
      render :edit
    end
  end

  private
  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :lyrics)
  end

end
