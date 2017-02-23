class InvitationsMailer < ApplicationMailer
  #def create(invitation)
  #  @invitation = invitation
  #
  #  mail to: invitation.email
  #end

  def approve(invitation)
    @invitation = invitation

    mail to: invitation.email
  end
end
