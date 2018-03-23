atom_feed do |feed|
  feed.title("Pictures by #{@user.name}")
  feed.updated(@pictures.first.updated_at) unless @pictures.empty?
  feed.author do |author|
    author.name(@user.name)
  end

  @pictures.each do |picture|
    feed.entry(picture) do |entry|
      entry.title("/p/#{picture.token}")
      entry.content(image_tag(picture.image.thumb_url("x300")) + content_tag(:p, picture.caption), type: "html")
    end
  end
end
