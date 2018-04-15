class InvitationsMailer < ApplicationMailer
  def approve(invitation)
    @invitation = invitation

    mail to: invitation.email
  end
end
