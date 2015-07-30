$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "houston/support_form/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "houston-support_form"
  s.version     = Houston::SupportForm::VERSION
  s.authors     = ["Bob Lail"]
  s.email       = ["bob.lailfamily@gmail.com"]
  s.homepage    = "https://github.com/concordia-publishing-house/houston-support_form"
  s.summary     = "Adds a form for CTS to enter either Feedback or ITSMs"
  s.description = "Adds a form for CTS to enter either Feedback or ITSMs"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
end
