require 'xmpp4r-simple'
require 'system_timer'

class PollableFIFOQueue < Array
  def poll(timeout, matcher_lambda = nil)
    SystemTimer.timeout(timeout) do
      loop do
        if (item = next_item)
          if matcher_lambda
            return item if matcher_lambda.call(item)
          else
            return item
          end
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
        
    def assert_received_join_request_from(sender)
      assert_received_message_matching(sender, /SOLVersion: 1.1; Command: JOIN;/, 
        "#{self.class} did not receive join request in time")
    end
    
    def assert_received_bid(amount, sender)
      assert_received_message_matching(sender, /SOLVersion: 1.1; Command: BID; Price: #{amount};/,
        "#{self.class} did not receive a bid of amount #{amount} from #{sender}")
    end
    
    private
    
    def assert_received_message_matching(sender, pattern, failure_message = nil)
      assert_not_nil @message_queue.poll(MESSAGE_POLL_TIMEOUT, lambda{ |message|
        return (message.from.bare == sender && pattern.match(message.body))
      }), failure_message
    end
  end
  
  module Actions
    ITEM_ID_AS_LOGIN = "auction-item-%s"
    XMPP_SERVER_HOST = "localhost"
    XMPP_PASSWORD    = "auction"
    AUCTION_RESOURCE = "auction"
    
    def announce_closed
      message = "SOLVersion: 1.1; Event: CLOSE;"
      @connection.deliver(@listener.last_jid, message)
    end
    
    def start_selling_item
      @listener = AuctionSniper::FakeAuctionServer::MessageListener.new(@connection, @message_queue)
      @listener.run
    end
    
    def report_price(price, increment, bidder)
      message = "SOLVersion: 1.1; Event: PRICE; CurrentPrice: #{price}; Increment: #{increment}; Bidder: #{bidder};"
      @connection.deliver(@listener.last_jid, message)
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
