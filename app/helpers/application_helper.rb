module ApplicationHelper
  def body_class
    "#{controller_path}/#{action_name}".tr("/", "-")
  end

  def email_munging(address)
    address.gsub("@", "(@_@)")
  end
end
