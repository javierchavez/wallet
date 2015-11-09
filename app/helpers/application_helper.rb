module ApplicationHelper

  # helper for defineing a page title in the main application layout
  #
  def title
    name = ""
    if @title.nil?
      name
    else
      "#{name} <small>#{@title}</small>"
    end
  end

end
