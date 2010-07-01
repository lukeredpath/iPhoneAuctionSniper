//
//  AuctionSniperTest.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "TestingCommon.h"
#import "AuctionSniper.h"
#import "AuctionSniperListener.h"
#import "Auction.h"

SniperSnapshot *snapshotFor(NSString *auctionID, NSInteger lastPrice, NSInteger lastBid, SniperState state) {
  return [[[SniperSnapshot alloc] initWithAuctionID:auctionID lastPrice:lastPrice lastBid:lastBid state:state] autorelease];
}

@interface AuctionSniperTest : SenTestCase
{
  AuctionSniper *sniper;
  id auction;
  id listener;
}
@property (nonatomic, retain) AuctionSniper *sniper;
@property (nonatomic, retain) id listener;
@property (nonatomic, retain) id auction;
@end

@implementation AuctionSniperTest

@synthesize sniper, listener, auction;

- (void)setUp;
{
  self.listener = [OCMockObject mockForProtocol:@protocol(AuctionSniperListener)];
  self.auction  = [OCMockObject mockForProtocol:@protocol(Auction)];
  self.sniper   = [[[AuctionSniper alloc] initWithAuction:self.auction] autorelease];
  self.sniper.delegate = self.listener;
}

- (void)tearDown;
{
  [self.listener verify];
}

- (void)testReportsLostWhenAuctionClosesImmediately;
{
  [[self.listener expect] auctionSniperLost];
  [self.sniper auctionClosed];
}

- (void)testBidsHigherAndReportsBiddingWhenNewPriceArrivesFromOtherBidder;
{
  NSInteger price = 100;
  NSInteger increment = 25;
  NSInteger bid = price + increment;
  
  [[self.auction expect] bid:bid];
  [[self.listener expect] auctionSniperBidding:equalTo(snapshotFor(@"auction-id", price, bid, SniperStateBidding))];
  
  [self.sniper currentPriceForAuction:price increment:increment priceSource:PriceFromOtherBidder];
}

- (void)testReportsWinningWhenNewPriceArrivesFromSniper;
{
  [[self.listener expect] auctionSniperWinning];
  [self.sniper currentPriceForAuction:1500 increment:100 priceSource:PriceFromSniper];
}

- (void)testReportsWonWhenAuctionClosesWhilstWinning;
{
  [[self.listener stub] auctionSniperWinning];
  [self.sniper currentPriceForAuction:1500 increment:100 priceSource:PriceFromSniper];
  [[self.listener expect] auctionSniperWon];
  [self.sniper auctionClosed];
}

- (void)testReportsLostWhenAuctionClosesWhilstBidding;
{
  [[self.auction stub] bid:1600];
  [[self.listener stub] auctionSniperBidding:instanceOf([SniperSnapshot class])];
  [self.sniper currentPriceForAuction:1500 increment:100 priceSource:PriceFromOtherBidder];
  [[self.listener expect] auctionSniperLost];
  [self.sniper auctionClosed];
}

@end

