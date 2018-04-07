class PicturePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.is_admin ||
      user == record.user ||
      record.public_setting? ||
      record.protected_setting? && record.protected_param == record.protected_secret
  end

  def lightbox?
    show?
  end

  def feature?
    user.is_admin
  end

  def unfeature?
    user.is_admin
  end
end
