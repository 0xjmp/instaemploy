class AngularTemplates
  include ActionView::Helpers::AssetTagHelper

  def self.cache
    @_cache ||= Hash.new
  end

  def initialize(app = nil)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'].match(/^\/templates\/./)
      @path = "#{Rails.root}/app/views#{env['PATH_INFO']}.html.slim"
      build_key!
      body = build_template!
      response = [body]
      status = 200
      headers = {
        "Content-Type" => "text/html; charset=utf-8",
        "Cache-Control" => "public, max-age=3600",
        "ETag" => @key,
      }
    else
      status, headers, response = @app.call(env)
    end
    [status, headers, response]
  end

  def build_key!
    # possibly cache by path alone in prod
    file = File.new(@path)
    @key = Digest::MD5.hexdigest(file.read)
    file.close
  end

  def build_template!
    if AngularTemplates.cache[@key]
      AngularTemplates.cache[@key]
    else
      template = Tilt.new(@path)
      output = template.render
      AngularTemplates.cache[@key] = output
      output
    end
  end
end