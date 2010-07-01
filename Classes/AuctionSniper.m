//
//  AuctionSniper.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSniper.h"
#import "XMPPAuction.h"

@interface AuctionSniper ()
@property (nonatomic, assign) SniperState state;
@end

@implementation AuctionSniper

@synthesize delegate;
@synthesize state;
@synthesize auction;

- (id)initWithAuction:(XMPPAuction *)anAuction;
{
  if (self = [super init]) {
    auction = [anAuction retain];
  }
  return self;
}

- (void)dealloc;
{
  [auction release];
  [super dealloc];
}

#pragma mark -
#pragma mark Auction events

- (void)auctionClosed;
{
  if (self.state == SniperStateWinning) {
    [self.delegate auctionSniperWon]; 
  } else {
    [self.delegate auctionSniperLost];
  }
}

- (void)currentPriceForAuction:(NSInteger)price increment:(NSInteger)increment priceSource:(AuctionPriceSource)priceSource;
{
  if (priceSource == PriceFromSniper) {
    self.state = SniperStateWinning;
    [self.delegate auctionSniperWinning]; 
  } else {
    self.state = SniperStateBidding;
    NSInteger bid = price + increment;
    [auction bid:bid];
    SniperSnapshot *snapshot = [[SniperSnapshot alloc] initWithAuctionID:@"auction-id" lastPrice:price lastBid:bid state:SniperStateBidding];
    [self.delegate auctionSniperBidding:snapshot];
    [snapshot release];
  }
}

@end

@implementation SniperSnapshot

@synthesize lastPrice, lastBid, state;

- (id)initWithAuctionID:(NSString *)anAuctionID lastPrice:(NSInteger)price lastBid:(NSInteger)bid state:(SniperState)sniperState;
{
  if (self = [super init]) {
    auctionID = [anAuctionID copy];
    lastPrice = price;
    lastBid = bid;
    state = sniperState;
  }
  return self;
}

- (BOOL)isForSameAuction:(NSString *)anAuctionID;
{
  return [anAuctionID isEqualToString:auctionID];
}

- (BOOL)isEqual:(id)object;
{
  if (![object isKindOfClass:[SniperSnapshot class]]) {
    return NO;
  }
  return [self isEqualToSnapshot:object];
}

- (BOOL)isEqualToSnapshot:(SniperSnapshot *)snapshot;
{
  return ([snapshot isForSameAuction:auctionID] && snapshot.lastPrice == self.lastPrice && snapshot.lastBid == self.lastBid && snapshot.state == self.state);
}

@end
