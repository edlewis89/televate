# -*- encoding: utf-8 -*-
# stub: blocks 2.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "blocks"
  s.version = "2.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andrew Hunter"]
  s.date = "2016-01-22"
  s.description = "Blocks goes beyond blocks and partials"
  s.email = ["hunterae@gmail.com"]
  s.homepage = "http://github.com/hunterae/blocks"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Blocks goes beyond blocks and partials"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<call_with_params>, ["~> 0.0.2"])
      s.add_runtime_dependency(%q<hashie>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<debugger>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<call_with_params>, ["~> 0.0.2"])
      s.add_dependency(%q<hashie>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<debugger>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<call_with_params>, ["~> 0.0.2"])
    s.add_dependency(%q<hashie>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<debugger>, [">= 0"])
  end
end
