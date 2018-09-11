Gem::Specification.new do |s|
  s.name        = 'sendcloud-mail'
  s.version     = '0.0.3'
  s.date        = '2018-09-03'
  s.summary     = 'A gem to send Mail with SendCloud API'
  s.description = 'A gem to send Mail with SendCloud API'
  s.authors     = ['dannio']
  s.email       = 'dcwongy@gmail.com'
  s.files       = ['lib/sendcloud-mail.rb']
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/dannio/sendcloud-mail'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rest-client', '>= 1.8.0'
end
