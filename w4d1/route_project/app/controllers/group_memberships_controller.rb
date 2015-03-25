class GroupMembershipsController < ApplicationController

  def create
    g_membership = GroupMembership.new(gm_params)
    if g_membership.save
      render json: g_membership
    else
      render(
        json: g_membership.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private
  def gm_params
    params[:group_membership].permit(:contact_group_id, :contact_id)
  end
end
