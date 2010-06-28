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

@interface AuctionSniperTest : SenTestCase
{
  AuctionSniper *sniper;
  id listener;
}
@property (nonatomic, retain) AuctionSniper *sniper;
@property (nonatomic, retain) id listener;
@end

@implementation AuctionSniperTest

@synthesize sniper, listener;

- (void)setUp;
{
  self.listener = [OCMockObject mockForProtocol:@protocol(AuctionSniperListener)];
  self.sniper   = [[[AuctionSniper alloc] initWithSniperListener:self.listener] autorelease];
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

@end

