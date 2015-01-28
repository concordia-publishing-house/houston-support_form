$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "houston/support_form/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "houston-support_form"
  s.version     = Houston::SupportForm::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Houston SupportForm."
  s.description = "TODO: Description of Houston SupportForm."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
end
