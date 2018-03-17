# Preview all emails at http://localhost:3000/rails/mailers/invitations
class InvitationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invitations/approve
  def approve
    InvitationsMailer.approve
  end

end
