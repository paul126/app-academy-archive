class CatRentalRequestsController < ApplicationController

  before_action :check_authenticity, only: [:approve, :deny]

  ##Dont need this, this was for dev purposes
  def index
    if params.has_key?(:cat_id)
      @rentals = CatRentalRequest.where(cat_id: params[:cat_id]).order(:start_date)
    end
    render :index
  end

  ##Dont need this, this was just for dev purposes
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
    @rental.user_id = current_user.id

    if @rental.save
      redirect_to cat_url(@rental.cat_id)
    else
      render :new
    end
  end

  def approve
    @rental = CatRentalRequest.find(params[:id])
    @rental.approve!
    redirect_to cat_url(Cat.find(@rental.cat_id))
  end

  def deny
    @rental = CatRentalRequest.find(params[:id])
    @rental.deny!
    redirect_to cat_url(Cat.find(@rental.cat_id))
  end

  def rental_cat_owner
    Cat.find(CatRentalRequest.find(params[:id]).cat_id).user_id
  end

  private
  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

  def check_authenticity
    if !signed_in? || current_user.id != rental_cat_owner
      flash[:notice] = "You cannot change the rental status of another's cat."
      redirect_to cat_url(Cat.find(params[:id]))
    end
  end

end
