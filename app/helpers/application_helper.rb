# frozen_string_literal: true

module ApplicationHelper

  def tag_links(tags)
    tags.split(',').map { |tag| link_to tag.strip, tag_path(tag.strip) }.join(', ')
  end

end
