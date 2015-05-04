# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'simple_show/version'

Gem::Specification.new do |s|
  s.name        = 'simple_show'
  s.version     = SimpleShow::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Philip Hallstrom']
  s.email       = ['philip@pjkh.com']
  s.homepage    = ''
  s.summary     = 'SimpleShow is to #show what SimpleForm is to #edit'
  s.description = 'SimpleShow is to #show what SimpleForm is to #edit'
  s.license     = 'MIT'

  s.rubyforge_project = 'simple_show'

  s.files         = `git ls-files`.split("\n")
  s.files         = s.files.delete_if { |path| path =~ /\.rvmrc/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
