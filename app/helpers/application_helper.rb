module ApplicationHelper
  def flash_messages(flash)
    %w(notice warning error).collect { |message|
      unless flash[message.to_sym].blank?
        content_tag(:p, flash[message.to_sym], :class => "flash " + message)
      end
    }.join
  end

  def display_tags(tags, options = {})
    options[:tagged_with] ||= false

    tags = tags.collect { |t| link_to(t.name, search_assets_path(:q => t.name)) }.join(", ")
    content_tag("p", :class => "tags") do
      if options[:tagged_with]
        "<span>Tagged With:</span> #{tags}"
      else
        tags
      end
    end
  end

  def thumbnail_uri(asset, size)
    if File.exists?(asset.file.path(size))
      image_tag(asset.file.url(size))
    else
      image_tag("/assets/default/#{size}.png")
    end
  end
end
