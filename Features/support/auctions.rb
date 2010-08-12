class Auction
  def self.auctions
    @auctions ||= {}
  end
  
  def self.create(item_id)
    auctions[item_id] = AuctionSniper::FakeAuctionServer.new(item_id).tap { |a| a.start_selling_item }
  end
  
  def self.for(item_id)
    auctions[item_id]
  end
  
  def self.each(&block)
    auctions.values.each(&block)
  end
end

