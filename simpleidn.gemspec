# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "simpleidn"
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Morten M\u{f8}ller Riis"]
  s.cert_chain = ["/Users/mmr/gem-public_cert.pem"]
  s.date = "2013-11-22"
  s.description = "This gem allows easy conversion from punycode ACE strings to unicode UTF-8 strings and visa versa."
  s.email = "mortenmoellerriis _AT_ gmail.com"
  s.extra_rdoc_files = ["README.rdoc", "lib/simpleidn.rb"]
  s.files = ["LICENCE", "Manifest", "README.rdoc", "Rakefile", "lib/simpleidn.rb", "simpleidn.gemspec", "spec/idn.rb", "spec/test_vectors.rb"]
  s.homepage = "http://github.com/mmriis/simpleidn"
  s.rdoc_options = ["--line-numbers", "--title", "Simpleidn", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "simpleidn"
  s.rubygems_version = "2.0.3"
  s.signing_key = "/Users/mmr/gem-private_key.pem"
  s.summary = "This gem allows easy conversion from punycode ACE strings to unicode UTF-8 strings and visa versa."
end
