#!/usr/bin/env ruby

unless ARGV[0]
  puts "robot-sweatshop.rb [init|start|stop|status]"
  exit
end

if ARGV[0] == 'init'
  config = File.expand_path "#{__dir__}/robot-sweatshop.pill"
  exec "sudo bluepill load #{config} --no-privileged"
else
  exec "sudo bluepill robot-sweatshop #{ARGV[0]} --no-privileged"
end