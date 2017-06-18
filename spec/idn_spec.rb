require 'spec_helper'
require 'test_vectors'

describe "SimpleIDN" do
  describe "to_unicode" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.sort.each do |testcase, vector|
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
    
  end
end
