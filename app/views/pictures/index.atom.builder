atom_feed do |feed|
  feed.title('Pictures')
  feed.updated(@pictures[0].created_at) if @pictures.length > 0

  @pictures.each do |picture|
    feed.entry(picture) do |entry|
      entry.title("#{picture.caption.presence || 'Picture'} by #{picture.user.name} (#{picture.token})")
      entry.content(src: URI.join(root_url, picture.image_url(:large)), type: 'image/jpeg')

      entry.author do |author|
        author.name(picture.user.name)
      end
    end
  end
end
