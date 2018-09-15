
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "travel_safe/version"

Gem::Specification.new do |spec|
  spec.name          = "travel_safe"
  spec.version       = '0.5.0'
  spec.authors       = ["'Lauren Pardee'"]
  spec.email         = ["'lap5151@gmail.com'"]
  spec.description    = "This Ruby Gem can be used to obtain travel advisories, embassy information and additional travel info. "
  spec.summary       = %q{This Ruby Gem provides a CLI to view advisories and additional travel information for the countries listed on the U.S. Department of State's travel website.}
  spec.homepage      = "https://github.com/lap5151/travel_safe"
  spec.license       = "MIT"
  spec.files       = ["lib/travel_safe.rb", "lib/travel_safe/cli.rb", "lib/travel_safe/scraper.rb", "lib/travel_safe/country.rb"]

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  #spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
#    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #end

  spec.executables   << "travel_safe"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "nokogiri", "~>1.8"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "colorize", ">= 0"


end
