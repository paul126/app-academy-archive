class ContactSharesController < ApplicationController
  def index
    render json: ContactShare.all
  end

  def create
    c_share = ContactShare.new(cs_params)
    if c_share.save
      render json: c_share
    else
      render(
        json: c_share.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    c_share = ContactShare.find(params[:id])
    if c_share.destroy
      render json: c_share
    else
      render(
        json: c_share.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def favorite
    c_share = ContactShare.find(params[:id])
    c_share.favorite = true
    if c_share.save
      render json: c_share
    else
      render(
        json: c_share.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  private
  def cs_params
    params[:contact_share].permit(:user_id, :contact_id)
  end
end
