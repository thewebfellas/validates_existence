# $:.reject! { |path| path.include? 'TextMate' }
require 'test/unit'

# Require and include test helpers
#
Dir[File.join(File.dirname(__FILE__), 'helpers', '*_test_helper.rb')].each do |helper|
  require helper
  /(.*?)_test_helper\.rb/.match File.basename(helper)
  class_name = $1.split('_').collect{ |name| name.downcase.capitalize }.join('') + 'TestHelper'
  Test::Unit::TestCase.send :include, Object.const_get(class_name) if Object.const_defined?(class_name)
end

# Load ActiveRecord
#
require 'rubygems'
gem 'activerecord'
require 'active_record'
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'

# Require the main init.rb for the plugin
#
require File.join(File.dirname(File.dirname(__FILE__)), 'init')