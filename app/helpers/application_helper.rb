module ApplicationHelper
  def page_meta_tags
    display_meta_tags(
      site: "Picture",
      separator: "-",
      reverse: true,
      icon: "/favicon.ico",
      canonical: url_for(only_path: false, locale: nil),
      og: {
        title: :title,
        site_name: :site,
        url: :canonical
      }
    )
  end

  def body_class
    "#{controller_path}/#{action_name}".tr("/", "-")
  end

  def email_munging(address)
    address.gsub("@", "(@_@)")
  end

  def language
    ISO::Language.identify(I18n.locale.to_s)
  end

  def pull_end_class
    case language.direction
    when "rtl" then "pull-left"
    when "ltr" then "pull-right"
    end
  end
end
