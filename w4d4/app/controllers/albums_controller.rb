class AlbumsController < ApplicationController

  before_action :require_login_to_view

  def index
    render :index
  end

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to band_url(@album.band)
    else
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    band = Band.find(@album.band)
    if @album.destroy
      #message
      redirect_to band_url(band)
    else
      #error
      render :edit
    end
  end

  private
  def album_params
    params.require(:album).permit(:title, :band_id, :album_type)
  end

end
