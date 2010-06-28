require 'xmpp4r-simple'
require 'system_timer'

class PollableFIFOQueue < Array
  def poll(timeout)
    SystemTimer.timeout(timeout) do
      loop do
        if (item = next_item)
          return item
        else
          sleep(0.1)
        end
      end
    end
  rescue Timeout::Error
    return nil
  end
  
  def next_item
    shift
  end
  
  def add(item)
    push(item)
  end
end

module AuctionSniper
  MESSAGE_POLL_TIMEOUT = 5
  
  module Assertions
    include Test::Unit::Assertions
        
    def assert_received_join_request_from_sniper
      assert_not_nil @message_queue.poll(MESSAGE_POLL_TIMEOUT), 
        "#{self.class} did not receive join request in time"
    end
  end
  
  module Actions
    ITEM_ID_AS_LOGIN = "auction-item-%s"
    XMPP_SERVER_HOST = "localhost"
    XMPP_PASSWORD    = "auction"
    AUCTION_RESOURCE = "auction"
    
    def announce_closed
      @connection.deliver(@listener.last_jid, "")
    end
    
    def start_selling_item
      @listener = AuctionSniper::FakeAuctionServer::MessageListener.new(@connection, @message_queue).run
    end
  end
  
  class FakeAuctionServer
    include Assertions
    include Actions
    
    attr_reader :auction_id
    
    def initialize(auction_id)
      @auction_id = auction_id
      @message_queue = PollableFIFOQueue.new
      @connection = Jabber::Simple.new(jid, XMPP_PASSWORD)
    end
    
    def stop
      @listener.kill if @listener
      @connection.disconnect if @connection
    end
    
    class MessageListener
      attr_reader :last_jid
      
      def initialize(connection, queue)
        @connection = connection
        @queue = queue
        @last_jid = nil
      end
      
      def run
        @thread = Thread.new do
          loop do
            @connection.received_messages do |msg|
              @queue.add(msg)
              @last_jid = msg.from
            end
            sleep 0.1
          end
        end
      end
      
      def kill
        @thread.kill
      end
    end
    
    private
    
    def jid
      "#{ITEM_ID_AS_LOGIN % auction_id}@#{XMPP_SERVER_HOST}/#{AUCTION_RESOURCE}"
    end
  end
end
