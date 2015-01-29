#!/usr/bin/env ruby
require_relative 'lib/file-queue'
require 'ezmq'

def enqueue(name, item)
  puts "enqueue #{name} #{item}"
  queue = FileQueue.new name
  queue.enqueue item
  queue.size.to_s
end

def dequeue(name)
  puts "dequeue #{name}"
  queue = FileQueue.new name  
  queue.dequeue
end

server = EZMQ::Server.new port: 5556
server.listen do |message|
  name, item = message.split ' ', 2
  is_dequeue_request = item.nil?
  is_dequeue_request ? dequeue(name) : enqueue(name, item)
end