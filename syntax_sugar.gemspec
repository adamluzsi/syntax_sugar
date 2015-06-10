# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'syntax_sugar/version'

Gem::Specification.new do |spec|
  spec.name          = "syntax_sugar"
  spec.version       = SyntaxSugar::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.summary       = %q{ Tool to create object that has dynamic reponse to methods, sended to it, and redirect it to a pre specified target object }
  spec.description   = %q{ Tool to create object that has dynamic reponse to methods, sended to it, and redirect it to a pre specified target object }
  spec.homepage      = "https://github.com/adamluzsi/syntax_sugar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

end
