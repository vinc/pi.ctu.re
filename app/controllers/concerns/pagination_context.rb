# Pagination on a page depend on the context.
#
# For example the previous and next links on a picture page change depending
# on where the visitor come from:
#
#   /p/99064241?from=explore&order=view
#   /p/f1444b59?from=user&order=time
#   /p/f2f0ef54?from=d0ad8cba (album token)
#
module PaginationContext
  extend ActiveSupport::Concern

  private

  # The instance variable `@from` is used to get the pagination context on a
  # page or to set it in links to the page.
  def set_from
    @from =
      if params[:from] || params[:album_token] || @album
        params[:from] || params[:album_token] || @album.token
      elsif params[:user_username] || @user
        "user"
      elsif controller_name == "explore"
        "explore"
      else
        "all"
      end
  end

  def set_order
    @order =
      if params[:order]
        params[:order]
      elsif controller_name == "explore"
        "view"
      else
        "time"
      end
  end
end
