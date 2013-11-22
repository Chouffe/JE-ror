module MailboxHelper

  def conversation_messages_badge(conversation, user)
    n = conversation.count_messages
    read = conversation.is_read? user
    css = "badge"
    if read
      css += ""
      # css += " badge-inverse"
    else
      css += " badge-info"
    end
    # content_tag(:span, content_tag(:span, "#{n}", class: css, :style => ("float:right;")), :style => ("width:50px;"))
    content_tag(:span, "#{n}", class: css)
  end

end
