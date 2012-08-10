# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'foshow'
  s.version           = '0.0.0'
  s.date              = '2012-08-10'

  s.summary       = %q{Show the code it took to make your rails app, in your rails app}
  s.description   = %q{
  Foshow provides a very simple interface that allows you to display your code in your application.
  This can be very useful for presentations when you don't want to create slides or jump back and
  forth between you code and your application.}

  s.authors       = ["Micah Cooper"]
  s.email         = ["mrmicahcooper@gmail.com"]
  s.homepage      = "https://github.com/mrmicahcooper/foshow"

  s.require_paths = %w[lib]

  s.extra_rdoc_files = %w[README.md LICENSE.md]

  s.add_dependency 'coderay'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'

  # = MANIFEST =
  s.files = %w[
    Gemfile
    LICENSE.md
    README.md
    Rakefile
    foshow.gemspec
    lib/foshow.rb
  ]
  # = MANIFEST =

  s.test_files    = s.files.grep(%r{^spec/})
end
