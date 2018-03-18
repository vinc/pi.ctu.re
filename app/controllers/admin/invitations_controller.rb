class Admin::InvitationsController < Admin::AdminController
  before_action :set_invitation, except: %i[index]

  def index
    @invitations = Invitation.order_by_time
  end

  def approve
    @invitation.update(approved_at: Time.zone.now)
    InvitationsMailer.approve(@invation).deliver_later

    respond_to do |format|
      format.html { redirect_back(fallback_location: admin_invitations_path) }
      format.json { head :no_content }
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find_by!(token: params[:token])
  end
end
