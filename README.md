# SimpleIDN

[![CI](https://github.com/mmriis/simpleidn/actions/workflows/ci.yml/badge.svg)](https://github.com/mmriis/simpleidn/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/simpleidn.svg)](https://rubygems.org/gems/simpleidn)

This gem converts punycode ACE strings to unicode UTF-8 strings and vice versa. It is pure Ruby and has no runtime dependencies.

The punycode conversion is based on the RFC 3492 C example implementation. It is simplified and does not preserve case. Input is first mapped with the UTS #46 (IDNA Compatible Preprocessing) mapping table. The bundled mapping table is generated from **Unicode 17.0.0**.

The gem works with Ruby 2.2 and later, JRuby, and TruffleRuby.

## Installation

```
gem install simpleidn
```

## Usage

```ruby
require 'simpleidn'

SimpleIDN.to_unicode("xn--mllerriis-l8a.com")
# => "møllerriis.com"

SimpleIDN.to_ascii("møllerriis.com")
# => "xn--mllerriis-l8a.com"
```

### Transitional processing

`to_ascii` and `to_unicode` accept an optional second argument, `transitional` (default `false`).
When `true`, the deviation characters `ß`, `ς`, ZWJ, and ZWNJ are mapped as in IDNA2003:

```ruby
SimpleIDN.to_ascii("faß.de")
# => "xn--fa-hia.de"

SimpleIDN.to_ascii("faß.de", true)
# => "fass.de"
```

Unicode removed transitional processing from UTS #46 in Unicode 16.0. The argument stays for backward compatibility. Use the default (`false`) unless you must match legacy IDNA2003 behavior.

### Errors

Invalid input raises `SimpleIDN::ConversionError`, a subclass of `RangeError`:

```ruby
SimpleIDN.to_unicode("xn---")
# => SimpleIDN::ConversionError
```

This includes `xn--` labels that decode to an empty or all-ASCII string, as required by UTS #46.

## Scope and known issues

- Case is not preserved.
- This is not a full UTS #46 / IDNA2008 implementation. The gem maps and converts labels. It does not enforce validity rules such as bidi rules, joiner context rules, or label length limits.

Please report any issues!

## Development

Run the tests:

```
bundle install
bundle exec rspec
```

The test suite includes the official Unicode `IdnaTestV2.txt` conformance vectors and the JOSEFSSON test vectors.

To update the UTS #46 mapping table, download the new `IdnaMappingTable.txt` and `IdnaTestV2.txt` from [unicode.org](https://www.unicode.org/Public/idna/latest/) into `tables/` and `spec/`, then regenerate:

```
ruby tables/generate_mapping_table.rb tables/IdnaMappingTable.txt > lib/simpleidn/uts46mapping.rb
```

## License

MIT. See [LICENCE](LICENCE).
