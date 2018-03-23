module ApplicationHelper
  def body_class
    "#{controller_path}/#{action_name}".tr("/", "-")
  end
end
