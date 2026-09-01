# Changelog

## 0.3.0 (2026-09-01)

- Update the UTS #46 / IDNA mapping table to Unicode 17.0.0 (was 15.1.0).
- `to_unicode` now raises `SimpleIDN::ConversionError` when an `xn--` label decodes to an empty or all-ASCII string. UTS #46 (Processing step 4.2) requires this, and it closes a spoofing loophole.
- Move CI from Travis to GitHub Actions. Test on Ruby 2.7–3.5, JRuby, and TruffleRuby, plus Windows and macOS.
- Reduce the packaged gem size. The gem no longer ships the raw `IdnaMappingTable.txt` source data.
- Add gemspec metadata (source code, changelog, bug tracker URIs) and require MFA for gem pushes.
- Convert the README to Markdown and expand the documentation.
- Add edge-case specs: encodings, frozen strings, emoji, transitional mode, alternative label separators, and the new error cases.

## 0.2.3 (2024-05-22)

- Update the UTS #46 / IDNA mapping table to Unicode 15.1.
- Drop the `unf` runtime dependency. The gem now has no runtime dependencies.

## 0.2.2 (2024-04-26)

- Fix file permissions in the packaged gem.

## 0.2.1 (2021-01-14)

- Punycode and UTS #46 mapping fixes.

Earlier releases are not documented here. See the git history.
