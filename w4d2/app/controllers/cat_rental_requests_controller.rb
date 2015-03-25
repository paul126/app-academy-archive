class CatRentalRequestsController < ApplicationController

  def index

    if params.has_key?(:cat_id)
      @rentals = CatRentalRequest.where(cat_id: params[:cat_id]).order(:start_date)
    end


    render :index
  end

  def show
    @rental = CatRentalRequest.find(params[:id])
    render :show
  end

  def new
    @rental = CatRentalRequest.new
    render :new
  end

  def create
    @rental = CatRentalRequest.new(rental_params)

    if @rental.save
      redirect_to cat_rental_request_url(@rental)
    else
      render :new
    end
  end

  private
  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
