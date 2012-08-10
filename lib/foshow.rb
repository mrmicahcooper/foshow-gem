require 'ostruct'
require 'singleton'

class Foshow

  include Singleton

  VERSION = "0.0.0"

  attr_accessor :views, :renderer

  def self.configure(&block)
    yield instance.config
  end

  def self.render(renderer)
    instance.renderer = renderer
    instance.render
  end

  def config
    @config ||= OpenStruct.new
  end

  def render
    renderer.content_tag(:section, id: 'code_viewer') do
      build_navigation + build_elements
    end.html_safe
  end

  private

  def show_keys
    @show_keys ||= config.marshal_dump.keys | defaults.marshal_dump.keys
  end

  def build_navigation
    renderer.content_tag(:nav) do
      "".tap do |html_container|
        show_keys.each do |name|
          html_container << " #{renderer.link_to(name, '#', class: name)}"
        end
      end.html_safe
    end
  end


  def defaults
    @defaults ||= OpenStruct.new({
      views: ["app/views/#{renderer.controller_name}/#{renderer.action_name}.html.haml"],
      controllers: ["app/controllers/#{renderer.controller_name}_controller.rb"],
      model: ["app/models/#{renderer.controller_name.singularize}.rb"],
      all: []
    })
  end

  def build_elements
    "".tap do |html_container|
      show_keys.each do |key|
        html_container << renderer.content_tag(:div, class: "#{key.to_s}") { show_code(defaults.send(key) || []).html_safe }
        html_container << renderer.content_tag(:div, class: "#{key.to_s}") { show_code(config_directories(key) || []).html_safe }
      end
    end.html_safe
  end

  def show_code(file_array, lang=:ruby)
    files = file_array.flatten
    "".tap do |html_string|
      files.each do |file|
        html_string << highlighted_code(file)
      end
    end
  end

  def config_directories(key)
    pages = config.send(key) || []
    a = pages.compact.map do |page|
      if page.is_a?(Hash)
        page["#{renderer.controller_name}##{renderer.action_name}"] || []
      else
        page
      end
    end
  end

  def highlighted_code(file)
    CodeRay.scan(" \#// #{file}\n\n" + code_string(file), file_lang(file)).div
  end

  def code_string(file)
    puts file
    read_file(file)
  end

  def read_file(file)
    begin
      File.read(file)
    rescue Errno::ENOENT
      "not found"
    end
  end

  def file_extension(file)
    File.extname(file)[1..-1]
  end

  def supported_file_types
    {
      ruby: "rb",
      javascript: "js",
      haml: "haml"
    }
  end

  def file_lang(file)
    supported_file_types.invert[file_extension(file)]
  end

end
