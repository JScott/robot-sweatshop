#!/usr/bin/env ruby
require_relative 'lib/file-queue'

@queues = []
[ARGV[0], "mirror-#{ARGV[0]}"].each do |queue_name|
  @queues.push({
    name: queue_name,
    queue: FileQueue.new(queue_name)
  })
end

loop do
  system 'clear'
  @queues.each do |q|
    puts "Queue: #{q[:name]}"
    puts "Size: #{q[:queue].size}", "#{'|'*q[:queue].size}"
    puts q[:queue].store[q[:name]].inspect
    puts
  end
  sleep 1
end