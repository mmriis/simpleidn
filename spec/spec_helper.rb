# encoding: utf-8
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require_relative '../lib/simpleidn'
