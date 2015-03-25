class ContactsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: (user.contacts + user.shared_contacts)
  end

  def show_favorites
    user = User.find(params[:user_id])
    render(
      json: user.contacts.where(favorite: true) +
        user.shared_contacts.where(favorite: true)
    )
  end

  def show
    render json: Contact.find(params[:id])
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render(
        json: contact.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    if contact.destroy
      render json: contact
    else
      render(
        json: contact.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def favorite
    contact = Contact.find(params[:id])
    contact.favorite = true
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  private
  def contact_params
    params[:contact].permit(:user_id, :email, :name)
  end
end
