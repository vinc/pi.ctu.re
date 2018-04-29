module PictureHelper
  def picture_description_format(description, options = {})
    if options[:truncate]
      description = truncate(description, length: options[:truncate], separator: ".")
      options.delete(:truncate)
    end

    simple_format(description, options).
      gsub(/(#\w+)/) { |tag| link_to(tag, search_pictures_path(q: tag)) }.
      html_safe
  end
end
