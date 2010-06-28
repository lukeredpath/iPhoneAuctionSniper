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

- (void)testReportsLostWhenAuctionCloses;
{
  [[self.listener expect] auctionSniperLost];
  [self.sniper auctionClosed];
}

- (void)testBidsHigherAndReportsBiddingWhenNewPriceArrives;
{
  NSInteger price = 100;
  NSInteger increment = 25;
  
  [[self.auction expect] bid:(price + increment)];
  [[self.listener expect] auctionSniperBidding];
  
  [self.sniper currentPriceForAuction:price increment:increment];
}

@end

