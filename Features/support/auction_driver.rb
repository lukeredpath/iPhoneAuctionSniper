module AuctionSniper
  class AuctionDriver
    def initialize(simulator_driver)
      @simulator_driver = simulator_driver
    end
    
    def shows_sniper_status?(status_string)
      @simulator_driver.screen.exists?(status_string, '//UILabel')
    end
  end
end
