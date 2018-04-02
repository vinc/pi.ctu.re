module PictureHelper
  def picture_caption_format(caption, options = {})
    if options[:truncate]
      caption = truncate(caption, length: options[:truncate], separator: ".")
      options.delete(:truncate)
    end

    simple_format(caption, options).
      gsub(/(#\w+)/) { |tag| link_to(tag, search_pictures_path(q: tag)) }.
      html_safe
  end
end
