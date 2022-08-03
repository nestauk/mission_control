module LinksHelper
  def linkable_path(linkable, opts = {})
    send("#{to_var(linkable)}_path", linkable, opts)
  end

  def linkable_links_path(linkable, opts = {})
    send("#{to_var(linkable)}_links_path", linkable, opts)
  end

  def linkable_link_path(linkable, link)
    send("#{to_var(linkable)}_link_path", linkable, link)
  end

  def new_linkable_link_path(linkable)
    send("new_#{to_var(linkable)}_link_path", linkable)
  end

  def edit_linkable_link_path(linkable, link)
    send("edit_#{to_var(linkable)}_link_path", linkable, link)
  end

  private

  def to_var(linkable)
    linkable.class.to_s.underscore
  end
end
