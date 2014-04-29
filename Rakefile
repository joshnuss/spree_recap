require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'spree/testing_support/extension_rake'

RSpec::Core::RakeTask.new

task :default => [:spec]

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'spree_recap'
  Rake::Task['extension:test_app'].invoke

  puts "Setting up spree_comments..."
  Spree::InstallGenerator.start ["--lib_name=spree_comments", "--auto-accept", "--migrate=true", "--seed=false", "--sample=false", "--quiet"]
end
