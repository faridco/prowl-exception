Gem::Specification.new do |s|
  s.authors     = %w{ Afhbl }
  s.email       = %w{ farid@bagishev.ru }

  s.name        = 'prowl-exception'
  s.summary     = "Send exception summary to prowl"
  s.description = %w{ Send exception summary to prowl }
  s.homepage    = 'https://github.com/afhbl/prowl-exception'

  s.version     = '0.0.3'
  s.date        = '2012-08-01'
  s.files       = `git ls-files`.split("\n")

  s.require_paths = ['lib']
  s.add_runtime_dependency 'prowler', '~> 1.2'
end
