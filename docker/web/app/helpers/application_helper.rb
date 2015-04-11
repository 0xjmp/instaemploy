module ApplicationHelper

  def markdown(text)
    options = {hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true, fenced_code: true, gh_blockcode: true}
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    syntax_highlighter(markdown.render(text)).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end

  def make_slug(text)
    text.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end