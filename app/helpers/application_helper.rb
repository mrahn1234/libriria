module ApplicationHelper
  include Pagy::Frontend
  
  def full_title(page_title = '')
    base_title = "Rails LibraryVLC"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  end
end
