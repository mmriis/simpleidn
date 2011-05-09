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
  end
  describe "to_ascii" do
    it "should pass all test cases" do
      TESTCASES_JOSEFSSON.sort.each do |testcase, vector|
        SimpleIDN.to_ascii(vector[0]) == vector[1]
      end
    end
  end
end
