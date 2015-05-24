require 'bundler/setup'
require 'kintama'
require 'ezmq'
require 'timeout'
require 'robot_sweatshop/config'
require 'robot_sweatshop/connections'
require_relative 'shared/scaffolding'
require_relative 'shared/helpers'
$stdout.sync = true

Kintama.on_start do
  Setup.empty_conveyor
  @pids = Processes.start %w(worker)
  @conveyor_thread = Setup.stub 'Server', port: configatron.conveyor_port
end

Kintama.on_finish do
  Processes.stop @pids
  @conveyor_thread.kill
end

describe 'the Worker' do
  include InputHelper
  include OutputHelper
  using ExtendedEZMQ

  setup do
    @pusher = EZMQ::Pusher.new :bind, port: configatron.worker_port
    @pusher.serialize_with_json!
    clear_worker_output
    clear_stub_output
  end

  teardown do
    @pusher.close
  end

  given 'valid job data is pushed' do
    setup do
      @pusher.send(worker_push, {})
      Timeout.timeout($a_while) do
        loop until File.exist?(worker_output)
        loop while File.read(stub_output).empty?
      end
      @worker_data = eval File.read(stub_output)
    end

    should 'run the commands' do
      assert_equal true, File.file?(worker_output)
    end

    should 'run with the context as environment variables' do
      assert_equal "hello world\n", File.read(worker_output)
    end

    should 'tell the conveyor that job is complete' do
      assert_equal 'finish', @worker_data[:method]
      assert_kind_of Fixnum, @worker_data[:data]
    end
  end
end
