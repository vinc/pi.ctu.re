atom_feed do |feed|
  feed.title("Pictures")
  feed.updated(@pictures[0].created_at) unless @pictures.empty?

  @pictures.each do |picture|
    feed.entry(picture) do |entry|
      entry.title("#{picture.caption.presence || 'Picture'} by #{picture.user.name} (#{picture.token})")
      entry.content(src: picture.image.thumb_url("800x800"), type: "image/jpeg")

      entry.author do |author|
        author.name(picture.user.name)
      end
    end
  end
end
