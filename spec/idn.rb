# encoding: utf-8
require 'rspec'
require 'simpleidn'
require 'test_vectors'
  
describe "SimpleIDN" do
  describe "to_unicode" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.sort.each do |testcase, vector|
        SimpleIDN.to_unicode(vector[1]).should == vector[0]
      end
    end
    
    it "should respect * and not try to decode it" do
      SimpleIDN.to_unicode("*.xn--mllerriis-l8a.com").should == "*.møllerriis.com"
    end
  end
  describe "to_ascii" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.sort.each do |testcase, vector|
				SimpleIDN.to_ascii(vector[0]).should == vector[1].downcase
      end
    end
    
    it "should respect * and not try to encode it" do
			SimpleIDN.to_ascii("*.hello.com").should == "*.hello.com"
		end
  end
end
