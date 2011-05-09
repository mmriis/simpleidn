# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simpleidn}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Morten Møller Riis"]
  s.cert_chain = ["/Users/mmr/gem-public_cert.pem"]
  s.date = %q{2011-05-09}
  s.description = %q{Gem to convert IDN domains}
  s.email = %q{mortenmoellerriis _AT_ gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/simpleidn.rb"]
  s.files = ["README.rdoc", "Rakefile", "lib/simpleidn.rb", "spec/idn.rb", "spec/test_vectors.rb", "test.rb", "Manifest", "simpleidn.gemspec"]
  s.homepage = %q{http://github.com/mmriis/simpleidn}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Simpleidn", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{simpleidn}
  s.rubygems_version = %q{1.6.2}
  s.signing_key = %q{/Users/mmr/gem-private_key.pem}
  s.summary = %q{Gem to convert IDN domains}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
