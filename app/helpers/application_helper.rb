module ApplicationHelper

  def full_title(subtitle)
    base_title = "BoardPoster"
    if subtitle.empty?
      base_title
    else
      "#{base_title} | #{subtitle}"
    end
  end

end
