module ApplicationHelper
  def flash_messages(flash)
    %w(notice warning error).collect { |message|
      unless flash[message.to_sym].blank?
        content_tag(:p, flash[message.to_sym], :class => "flash " + message)
      end
    }.join
  end

  def display_tags(tags)
    content_tag("p", :class => "tags") do
      tags.collect { |t| link_to(t.name, search_assets_path(:q => t.name)) }.join(", ")
    end
  end
end
