class PicturePolicy < ApplicationPolicy
  def feature?
    user.is_admin
  end

  def unfeature?
    user.is_admin
  end
end
