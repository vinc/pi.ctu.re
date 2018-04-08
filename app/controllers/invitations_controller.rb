class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.create(invitation_params)
    respond_with(@invitation, location: -> { root_path })
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
