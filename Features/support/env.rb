require 'icuke/cucumber'
$LOAD_PATH << File.join(File.dirname(__FILE__), *%w[.. support])

OPENFIRE_PATH = "/opt/openfire/bin/openfire"

ICukeWorld.configure do
  set :target, 'Testing'
end

module OpenfireHelpers
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
  
  def openfire
    @openfire ||= Openfire.new(OPENFIRE_PATH)
  end
end

World(OpenfireHelpers)

Before do
  openfire.start
  raise "Could not start Openfire" unless openfire.running?
end

After do
  openfire.stop
end
