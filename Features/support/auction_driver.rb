require 'icuke/simulator_driver/assertions'

module AuctionSniper
  class AuctionDriver
    def initialize(simulator_driver)
      @simulator_driver = simulator_driver
    end
    
    def assert_shows_sniper_status(status_string)
      @simulator_driver.assert_text_on_screen(status_string)
    end
  end
end
