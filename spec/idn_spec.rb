# encoding: utf-8
require 'spec_helper'
require 'test_vectors'

describe "SimpleIDN" do
  describe "to_unicode" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.sort.each do |testcase, vector|
        next if vector[2] # Skip non-reversable
        expect(SimpleIDN.to_unicode(vector[1])).to eq(vector[0])
      end
    end

    it "should respect * and not try to decode it" do
      expect(SimpleIDN.to_unicode("*.xn--mllerriis-l8a.com")).to eq("*.møllerriis.com")
    end

    it "should respect leading _ and not try to encode it" do
      expect(SimpleIDN.to_unicode("_something.xn--mllerriis-l8a.com")).to eq("_something.møllerriis.com")
    end

    it "should return nil for nil" do
      expect(SimpleIDN.to_unicode(nil)).to be_nil
    end

    it "should return . if only . given" do
      # https://github.com/mmriis/simpleidn/issues/3
     expect(SimpleIDN.to_unicode('.')).to eq('.')
    end

    it "raises when the input is an invalid ACE" do
      expect { SimpleIDN.to_unicode('xn---') }.to raise_error(SimpleIDN::ConversionError)
    end
  end

  describe "to_ascii" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.sort.each do |testcase, vector|
        expect(SimpleIDN.to_ascii(vector[0])).to eq(vector[1])
      end
    end

    it "should respect * and not try to encode it" do
      expect(SimpleIDN.to_ascii("*.hello.com")).to eq("*.hello.com")
    end
    
    it "should respect @ and not try to encode it" do
      expect(SimpleIDN.to_ascii("@.hello.com")).to eq("@.hello.com")
    end

    it "should respect leading _ and not try to encode it" do
      expect(SimpleIDN.to_ascii("_something.example.org")).to eq("_something.example.org")
    end

    it "should return nil for nil" do
      expect(SimpleIDN.to_ascii(nil)).to be_nil
    end

    it "should return . if only . given" do
      # https://github.com/mmriis/simpleidn/issues/3
      expect(SimpleIDN.to_ascii('.')).to eq('.')
    end

    it "should return @ if @ is given" do
      expect(SimpleIDN.to_ascii('@')).to eq('@')
    end

    it "should handle issue 8" do
      expect(SimpleIDN.to_ascii('verm├Âgensberater')).to eq('xn--vermgensberater-6jb1778m')
    end
  end

  describe "uts #46" do
    it "should pass all test cases" do
      IO.foreach(File.join(File.dirname(File.expand_path(__FILE__)), 'IdnaTestV2.txt')) do |line|
        line = line.split('#').first
        next if line.nil?
        parts = line.split(';').map{|p|p.strip}
        next if parts[1].nil?

        begin
          parts[0].gsub!(/\\u([0-9a-fA-F]{4})/){|m| $1.to_i(16).chr(Encoding::UTF_8)}
          parts[1].gsub!(/\\u([0-9a-fA-F]{4})/){|m| $1.to_i(16).chr(Encoding::UTF_8)}
        rescue RangeError
          next
        end
        parts[1] = parts[0] if parts[1].empty?
        parts[3] = parts[1] if parts[3].empty?
        parts[5] = parts[3] if parts[5].empty?

        parts[2] = "[]" if parts[2].empty?
        parts[4] = parts[2] if parts[4].empty?
        parts[6] = parts[4] if parts[6].empty?

        if parts[2].include?("P4") # The only supported error code for now
          expect { SimpleIDN.to_unicode(parts[0]) }.to raise_error(SimpleIDN::ConversionError)
        elsif parts[2] == "[]"
          expect(SimpleIDN.to_unicode(parts[0])).to eq(parts[1])
        end
        if parts[4] == "[]"
          expect(SimpleIDN.to_ascii(parts[0], false)).to eq(parts[3])
        end
        if parts[6] == "[]"
          expect(SimpleIDN.to_ascii(parts[0], true)).to eq(parts[5])
        end
      end
    end
  end
end
