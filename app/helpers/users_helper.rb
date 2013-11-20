module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50, class: "gravatar" })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    cl = options[:class]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.full_name, class: cl)
  end

  def mail_badge(user)
    n = user.mailbox.inbox({:read => false}).count
    css = "badge"
    if n > 10
      css += " badge-important"
    elsif n > 0
      css += " badge-info"
    end
    # content_tag(:span, content_tag(:span, "#{n}", class: css, :style => ("float:right;")), :style => ("width:50px;"))
    content_tag(:span, "#{n}", class: css)
  end
end
