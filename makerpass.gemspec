$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "makerpass/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "makerpass-rails"
  s.version     = MakerPass::VERSION
  s.authors     = ["Gilbert"]
  s.email       = ["gilbert@makersquare.com"]
  s.homepage    = "https://github.com/makersquare/makerpass-rails"
  s.summary     = "A rails engine for getting up and running with MakerPass."
  s.description = "A rails engine for getting up and running with MakerPass."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency "figaro", "~> 1.0.0"
  s.add_dependency "omniauth-makersquare", ">= 0.0.2"

  s.add_development_dependency "pg"
end
