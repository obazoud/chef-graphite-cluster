require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

# Style tests. RuboCop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any'],
      tags: ['~FC003']
    }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

# Integration tests. Kitchen.ci
namespace :integration do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.vagrant.yml')
    Kitchen::Config.new(loader: @loader).instances.each do |instance|
      instance.test(:always)
    end
  end

  desc 'Run Test Kitchen with Docker'
  task :docker do
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.yml')
    Kitchen::Config.new(loader: @loader).instances.each do |instance|
      instance.test(:always)
    end
  end
end

desc 'Run all tests on Travis'
task travis: %w( style spec )

desc 'Run all tests (Vagrant)'
task vagrant: %w( style spec integration:vagrant )

# Default
task default: %w( style spec integration:docker )
