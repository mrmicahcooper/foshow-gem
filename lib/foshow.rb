class Foshow

  VERSION = "0.0.0"

  attr_accessor :renderer, :defaults, :configuration
  delegate :action_name, :controller_name, :content_tag, :link_to, to: :renderer

  def self.configure(&block)
    @fo = new
    @fo.configuration = block.call
  end

  def self.render(renderer)
    @fo.renderer = renderer
    @fo.render
  end

  def render
    content_tag(:section, id: 'code_viewer') do
      build_navigation + build_elements
    end.html_safe
  end

  def build_navigation
    content_tag(:nav) do
      "".tap do |html_container|
        show_keys.each do |name|
          html_container << " #{link_to(name, '#', class: name)}"
        end
      end.html_safe
    end
  end

  def build_elements
    "".tap do |html_container|
      show_keys.each do |key|
        html_container << content_tag(:div, class: "#{key.to_s}") { show_code(defaults[key] || []).html_safe }
        html_container << content_tag(:div, class: "#{key.to_s}") { show_code(config_directories(key) || []).html_safe }
      end
    end.html_safe
  end

  def config_directories(key)
    if configuration[key].is_a?(Hash)
      configuration[key]["#{controller_name}##{action_name}"] || []
    else
      configuration[key]
    end
  end

  def show_keys
    @show_keys ||= configuration.keys | defaults.keys
  end

  def defaults
    @default ||= {
      views: ["app/views/#{controller_name}/#{action_name}.html.haml"],
      controllers: ["app/controllers/#{controller_name}_controller.rb"],
      model: ["app/models/#{controller_name.singularize}.rb"],
      all: []
    }
  end

  def show_code(file_array, lang=:ruby)
    "".tap do |html_string|
      file_array.flatten.each do |file|
        html_string << highlighted_code(file)
      end
    end
  end

  def highlighted_code(file)
    CodeRay.scan(" \#// #{file}\n\n" + code_string(file), file_lang(file)).div
  end

  def code_string(file)
    read_file(file)
  end

  def read_file(file)
    File.read(file)
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
