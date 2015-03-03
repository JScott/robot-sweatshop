#!/usr/bin/env ruby
require 'yaml'
require 'commander/import'
require 'colorize'
require_relative 'lib/common'
require_relative 'lib/job'
require_relative 'lib/inspect'

# :name is optional, otherwise uses the basename of this executable
program :name, 'Robot Sweatshop'
program :version, '0.1.0'
program :description, 'A lightweight, unopinionated CI server'
program :help, 'Author', 'Justin Scott <jvscott@gmail.com>'

# default_command :bootstrap

command :job do |c|
  c.syntax = 'sweatshop job <name>'
  c.description = 'Creates and edits jobs'
  c.action do |args|
    with_job_file for_job: args.first do |file|
      create_and_edit job_file: file
    end
  end
end

command :inspect do |c|
  c.syntax = 'sweatshop.rb inspect <name>'
  c.description = 'Verify the structure of a job'
  c.action do |args|
    with_job_file for_job: args.first do |file|
      validate job_file: file
    end
  end
end


# command :bar do |c|
#   c.syntax = 'foobar bar [options]'
#   c.description = 'Display bar with optional prefix and suffix'
#   c.option '--prefix STRING', String, 'Adds a prefix to bar'
#   c.option '--suffix STRING', String, 'Adds a suffix to bar'
#   c.action do |args, options|
#     options.default :prefix => '(', :suffix => ')'
#     say "#{options.prefix}bar#{options.suffix}"
#   end
# end
