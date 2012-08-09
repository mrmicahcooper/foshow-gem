require 'rails/generators/base'

class Foshow
  class InstallGenerator < Rails::Generators::Base

    def generate
      template 'foshow.js', 'app/assets/javascripts/foshow.js'
      template 'foshow.css', 'app/assets/stylesheets/foshow.css'
    end

    def self.source_root
      File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end

  end
end
