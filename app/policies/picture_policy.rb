class PicturePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? ||
      user == record.user ||
      record.enabled? && record.public_setting? ||
      record.enabled? && record.protected_setting? && record.protected_param == record.protected_secret
  end

  def feature?
    user.admin?
  end

  def unfeature?
    user.admin?
  end

  def upload?
    user.balance.positive? || !Rail.configuration.payment_enabled
  end
end
