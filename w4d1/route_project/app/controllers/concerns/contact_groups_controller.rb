class ContactGroupsController < ApplicationController
  def index
    render json: ContactGroup.all
  end

  def create
    c_group = ContactGroup.new(c_group_params)
    if c_group.save
      render json: c_group
    else
      render(
        json: c_group.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    c_group = ContactGroup.find(params[:id])
    if c_group.destroy
      render json: c_group
    else
      render(
        json: c_group.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def show
    c_group = ContactGroup.find(params[:id])
    render json: [c_group, c_group.contacts]
  end

  private
  def c_group_params
    params[:contact_group].permit(:user_id, :name)
  end
end
