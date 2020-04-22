module ApplicationHelper
  def full_title(add_title = '')
    base_title = 'HSPortal'
    if add_title.empty?
      base_title
    else
      add_title + " | " + base_title
    end
  end
end
