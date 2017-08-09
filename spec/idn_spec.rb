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
      IO.foreach(File.join(File.dirname(File.expand_path(__FILE__)), 'IdnaTest.txt')) do |line|
        line = line.split('#').first
        next if line.nil?
        parts = line.split(';').map{|p|p.strip}
        next if parts[1].nil?

        begin
          parts[1].gsub!(/\\u([0-9a-fA-F]{4})/){|m| $1.to_i(16).chr(Encoding::UTF_8)}
          parts[2].gsub!(/\\u([0-9a-fA-F]{4})/){|m| $1.to_i(16).chr(Encoding::UTF_8)}
        rescue RangeError
          next
        end
        parts[2] = parts[1] if parts[2].empty?
        parts[3] = parts[2] if parts[3].empty?
        transitional = (parts[0] == 'T')
        unless parts[2].start_with?('[')
          expect(SimpleIDN.to_unicode(parts[1])).to eq(parts[2])
        end
        unless parts[3].start_with?('[')
          expect(SimpleIDN.to_ascii(parts[1], transitional)).to eq(parts[3])
        end
      end
    end
  end
end
