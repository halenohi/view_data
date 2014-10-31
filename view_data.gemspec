$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "view_data/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "view_data"
  s.version     = ViewData::VERSION
  s.authors     = ["Kozo Yamagata"]
  s.email       = ["tune002@gmail.com"]
  s.homepage    = "https://github.com/halenohi/view_data"
  s.summary     = "inject view's instance variables"
  s.description = "prototype development and record caching for views"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"
end
