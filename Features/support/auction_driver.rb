require 'icuke/simulator_driver/assertions'

module AuctionSniper
  class AuctionDriver
    def initialize(simulator_driver)
      @simulator_driver = simulator_driver
    end
    
    def assert_shows_sniper_status(status_string)
      @simulator_driver.refresh
      @simulator_driver.assert_text_on_screen_with_scope(status_string, "//UITableView//UITableViewCell")
    end
  end
end
