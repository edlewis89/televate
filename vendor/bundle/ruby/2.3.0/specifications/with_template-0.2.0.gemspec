# -*- encoding: utf-8 -*-
# stub: with_template 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "with_template"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andrew Hunter"]
  s.date = "2016-01-22"
  s.description = "Render a template (partial) and easily override any of the components of the template"
  s.email = ["hunterae@gmail.com"]
  s.homepage = "http://github.com/hunterae/with_template"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Render a template (partial) and easily override any of the components of the template"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<blocks>, ["~> 2.8.0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, ["~> 3.5.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<blocks>, ["~> 2.8.0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<shoulda>, ["~> 3.5.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<blocks>, ["~> 2.8.0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<shoulda>, ["~> 3.5.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
