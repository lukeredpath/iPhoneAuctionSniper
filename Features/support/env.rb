require 'icuke/cucumber'
require 'test/unit/assertions'

World(Test::Unit::Assertions)

OPENFIRE_PATH = "/opt/openfire/bin/openfire"

ICukeWorld.configure do
  set :target, 'Testing'
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
  sleep(4) # give the daemon a chance to start up
end

at_exit do
  $openfire.stop
end
