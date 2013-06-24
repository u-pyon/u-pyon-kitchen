require 'rake'
require 'rspec/core/rake_task'

if ENV['ENV'] == 'production'
  ENV['VM'] = nil
else
  ENV['VM'] = '10.0.2.15'
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end
