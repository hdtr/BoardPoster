module ApplicationHelper

  def full_title(subtitle)
    base_title = "BoardPoster"
    if subtitle.empty?
      base_title
    else
      "#{base_title} | #{subtitle}"
    end
  end

  # source: http://stackoverflow.com/questions/4791538/rails-3-submit-form-with-link
  # hack for creating regular links instead of submit buttons in form_for forms

  def link_to_submit(*args, &block)
    link_to_function (block_given? ? capture(&block) : args[0]), "$(this).closest('form').submit()", args.extract_options!
  end


end
