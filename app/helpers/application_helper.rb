module ApplicationHelper
  def full_title(add_title = '')
    base_title = 'HSPortal'
    if add_title.empty?
      base_title
    else
      add_title + " | " + base_title
    end
  end

  def full_headline(custom_word)
    base = 'HSPortalへようこそ'
    if custom_word.empty?
      base
    else
      custom_word
    end
  end
end
