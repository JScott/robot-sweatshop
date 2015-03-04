#!/usr/bin/env ruby
require 'sinatra'
require 'ezmq'
require 'json'
require_relative '../../config'

configure do
  set :port, configatron.input.http.port
  set :bind, configatron.input.http.bind
  set :output_queue, 'raw-payload'
end

get '/' do
  'Everything\'s on schedule!'
end

post '/:format/payload-for/:job_name' do
  puts "Received #{params['format']} payload for #{params['job_name']}"
  request.body.rewind
  hash = {
    payload: request.body.read,
    format: params['format'],
    job_name: params['job_name']
  }
  client = EZMQ::Client.new port: 5556
  client.request "#{settings.output_queue} #{JSON.generate hash}"
end
