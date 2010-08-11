require 'simcontrol'
require 'simcontrol/integration/cucumber'
require 'test/unit/assertions'
require 'system_timer'
require File.join(File.dirname(__FILE__), *%w[global])

World(Test::Unit::Assertions)

OPENFIRE_PATH = "/opt/openfire/bin/openfire"
OPENFIRE_PORT = 5222

SimControlWorld.configure do
  set :target, 'Testing'
end

def wait_until(timeout, condition_lambda)
  SystemTimer.timeout(timeout) do
    loop do
      satisfied = condition_lambda.call
      return if satisfied
      sleep(0.1)
    end
  end
end

def wait_for_openfire
  wait_until(5, lambda {
    begin
      return TCPSocket.new('localhost', OPENFIRE_PORT)
    rescue Exception => e
      return false
    end
  })
end

class Openfire
  def initialize(path)
    @path = path
  end

  def start
    run "start"
  end

  def stop
    run "stop"
  end

  def running?
    run "status" # returns > 0 if not running
  end

  private

  def run(command)
    system("#{@path} #{command} > /dev/null")
  end
end

$openfire ||= Openfire.new(OPENFIRE_PATH)

AfterConfiguration do
  $openfire.start
  raise "Could not start Openfire" unless $openfire.running?
  begin
    wait_for_openfire
  rescue Timeout::Error
    raise "Could not connect to Openfire in a timely manner"
  end
end

at_exit do
  $openfire.stop
end

