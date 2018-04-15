atom_feed do |feed|
  feed.title("Pictures")
  feed.updated(@pictures[0].created_at) unless @pictures.empty?

  @pictures.each do |picture|
    feed.entry(picture) do |entry|
      entry.title("/p/#{picture.token}")
      entry.content(image_tag(picture.image.thumb_url("x300")) + content_tag(:p, picture.caption), type: "html")
      entry.author do |author|
        author.name(picture.user.name)
      end
    end
  end
end
