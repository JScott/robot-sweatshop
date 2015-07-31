require 'yaml'

# TODO: per-user temp file
CONFIG_PATH = File.expand_path '~/.robot_sweatshop/compiled_config.yaml'
CONFIG = YAML.load_file CONFIG_PATH
PID_PATH = CONFIG[:pidfile_path]

Eye.config do
  logger "#{CONFIG[:logfile_path]}/eye.log"
end

Eye.application :robot_sweatshop do
  trigger :flapping, times: 10, within: 1.minute, retry_in: 10.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3
  working_dir CONFIG[:working_path]

  group 'services' do
    process :job_dictionary do
      pid_file "#{PID_PATH}/job-dictionary.pid"
      start_command "#{__dir__}/bin/sweatshop-job-dictionary"
      daemonize true
    end
    process :payload_parser do
      pid_file "#{PID_PATH}/payload-parser.pid"
      start_command "#{__dir__}/bin/sweatshop-payload-parser"
      daemonize true
    end
    process :conveyor do
      pid_file "#{PID_PATH}/conveyor.pid"
      start_command "#{__dir__}/bin/sweatshop-conveyor"
      daemonize true
    end
  end

  process :overseer do
    pid_file "#{PID_PATH}/overseer.pid"
    start_command "#{__dir__}/bin/sweatshop-overseer"
    daemonize true
  end
  process :api do
    pid_file "#{PID_PATH}/api.pid"
    start_command "#{__dir__}/bin/sweatshop-api"
    daemonize true
  end
  process :assembler do
    pid_file "#{PID_PATH}/assembler.pid"
    start_command "#{__dir__}/bin/sweatshop-assembler"
    daemonize true
  end
  process :worker do
    pid_file "#{PID_PATH}/worker.pid"
    start_command "#{__dir__}/bin/sweatshop-worker"
    daemonize true
  end
  process :logger do
    pid_file "#{PID_PATH}/logger.pid"
    start_command "#{__dir__}/bin/sweatshop-logger"
    daemonize true
  end
end
