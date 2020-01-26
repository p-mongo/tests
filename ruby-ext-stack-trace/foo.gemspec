Gem::Specification.new do |s|
  s.name              = 'foo'
  s.version = '0.0.1'
  s.extensions = ['ext/extconf.rb']
  s.summary = 'foo'
  s.authors = 'foo'
  s.license           = 'MIT'
  s.homepage = 'http://foo'
    s.files      += Dir.glob('ext/**/*.{c,h,rb}')
end
