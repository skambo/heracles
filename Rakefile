require_relative 'config/environment'
require 'rake/testtask'

task :unit_task do                                  #
  Rake::TestTask.new("unit") do |t|
    t.pattern = "tests/unit/*.rb"
  end
end

task :integration_task do                                  #
  Rake::TestTask.new("integration") do |t|
    t.pattern = "tests/integration/*.rb"
  end
end

task :unit do
  Rake::Task["unit_task"].invoke
end

task :integration do
  Rake::Task["integration_task"].invoke
end

