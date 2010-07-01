require 'icuke/simulator_driver/assertions'

module AuctionSniper
  class AuctionDriver
    def initialize(simulator_driver)
      @simulator_driver = simulator_driver
    end
    
    def assert_shows_sniper_status(auction_id, price, bid, status_string)
      @simulator_driver.refresh
      
      cell_scope = "//UITableView//AuctionSniperCell"
      [auction_id, price, bid, status_string].each do |property|
        next if property.nil?
        @simulator_driver.assert_text_on_screen_with_scope(property, cell_scope)
      end
    end
  end
end
