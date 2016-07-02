$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "houston/support_form/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "houston-support_form"
  spec.version     = Houston::SupportForm::VERSION
  spec.authors     = ["Bob Lail"]
  spec.email       = ["bob.lailfamily@gmail.com"]

  spec.summary     = "Adds a form for CTS to enter either Feedback or ITSMs"
  spec.description = "Adds a form for CTS to enter either Feedback or ITSMs"
  spec.homepage    = "https://github.com/cph/houston-support_form"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.test_files = Dir["test/**/*"]

  spec.add_dependency "houston-core", ">= 0.7.0.beta2"

  spec.add_development_dependency "bundler", "~> 1.11.2"
  spec.add_development_dependency "rake", "~> 11.2"
end
