module DateHelper

  def pretty_print_date_tag(date)
    unless date.nil?
      date.strftime(pretty_datetime_format_long)
    end
  end

  def pretty_datetime_format_long
    "%B %d, %Y at %I:%M %p"
  end

end