Gem::Specification.new do |s|
  s.name              = "dmenu"
  s.summary           = "A Ruby OOP wrapper around dmenu."
  s.description       = "A Ruby OOP wrapper around dmenu."
  s.version           = "0.0.1"
  s.author            = "Dominik Honnef"
  s.email             = "dominikh@fork-bomb.org"
  s.date              = Date.today.to_s
  s.require_path      = "lib"
  s.homepage          = "http://fork-bomb.org"

  s.has_rdoc = 'yard'

  s.required_ruby_version = '>= 1.9.1'

  s.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*',
                'README*', 'LICENSE*']
end
