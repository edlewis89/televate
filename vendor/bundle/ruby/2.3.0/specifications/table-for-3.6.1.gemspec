# -*- encoding: utf-8 -*-
# stub: table-for 3.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "table-for"
  s.version = "3.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andrew Hunter"]
  s.date = "2017-05-13"
  s.description = "table-for is a table builder for an array of objects, easily allowing overriding of how any aspect of the table is generated"
  s.email = ["hunterae@gmail.com"]
  s.homepage = "http://github.com/hunterae/table-for"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "table-for is a table builder for an array of objects, easily allowing overriding of how any aspect of the table is generated"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<with_template>, ["~> 0.2.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.0.0.beta.20"])
      s.add_development_dependency(%q<mocha>, ["= 0.10.3"])
      s.add_development_dependency(%q<xml-simple>, ["= 1.1.1"])
      s.add_development_dependency(%q<supermodel>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<with_model>, [">= 0"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<with_template>, ["~> 0.2.0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.0.0.beta.20"])
      s.add_dependency(%q<mocha>, ["= 0.10.3"])
      s.add_dependency(%q<xml-simple>, ["= 1.1.1"])
      s.add_dependency(%q<supermodel>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<with_model>, [">= 0"])
      s.add_dependency(%q<byebug>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<with_template>, ["~> 0.2.0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.0.0.beta.20"])
    s.add_dependency(%q<mocha>, ["= 0.10.3"])
    s.add_dependency(%q<xml-simple>, ["= 1.1.1"])
    s.add_dependency(%q<supermodel>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<with_model>, [">= 0"])
    s.add_dependency(%q<byebug>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
