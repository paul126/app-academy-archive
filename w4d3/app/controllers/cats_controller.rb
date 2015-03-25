class CatsController < ApplicationController

  before_action :check_authenticity, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat)
      .permit(:name, :sex, :birth_date, :color, :description)
  end

  def check_authenticity
    if !signed_in? || current_user.id != Cat.find(params[:id]).user_id 
      flash[:notice] = "You cannot edit someone else's cat."
      redirect_to cat_url(Cat.find(params[:id]))
    end
  end

end
