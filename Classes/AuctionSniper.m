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
@property (nonatomic, retain, readwrite) SniperSnapshot *currentSnapshot;
- (void)notifyChange;
@end

@interface SniperSnapshot (Factories)
+ (id)joining:(NSString *)auctionID;
- (id)bidding:(NSInteger)lastPrice nextBid:(NSInteger)bid;
- (id)winning:(NSInteger)price currentBid:(NSInteger)bid;
- (id)closed;
- (SniperState)stateWhenClosed;
@end

@implementation AuctionSniper

@synthesize delegate;
@synthesize auction;
@synthesize auctionID;
@synthesize currentSnapshot;

- (id)initWithAuction:(id<Auction>)anAuction auctionID:(NSString *)anAuctionID;
{
  if (self = [super init]) {
    auction = [anAuction retain];
    auctionID = [anAuctionID copy];
    self.currentSnapshot = [SniperSnapshot joining:auctionID];
  }
  return self;
}

- (void)dealloc;
{
  [auctionID release];
  [auction release];
  [super dealloc];
}

#pragma mark -
#pragma mark Auction events

- (void)auctionClosed;
{
  self.currentSnapshot = [self.currentSnapshot closed];
  [self notifyChange];
}

- (void)currentPriceForAuction:(NSInteger)price increment:(NSInteger)increment priceSource:(AuctionPriceSource)priceSource;
{
  switch (priceSource) {
    case PriceFromSniper: {
      self.currentSnapshot = [self.currentSnapshot winning:price currentBid:price];
      break; 
    }
    case PriceFromOtherBidder: {
      NSInteger bid = price + increment;
      [auction bid:bid];
      self.currentSnapshot = [self.currentSnapshot bidding:price nextBid:bid];
      break;
    }
    default:
      @throw NSInternalInconsistencyException;
      break;
  }
  [self notifyChange];
}

- (void)notifyChange;
{
  [self.delegate auctionSniperChanged:self.currentSnapshot];
}

@end

@implementation SniperSnapshot

@synthesize lastPrice, lastBid, state, auctionID;

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

- (void)dealloc;
{
  [auctionID release];
  [super dealloc];
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

@implementation SniperSnapshot (Factories)

+ (id)joining:(NSString *)auctionID;
{
  return [[[self alloc] initWithAuctionID:auctionID lastPrice:0 lastBid:0 state:SniperStateJoining] autorelease];
}

- (id)bidding:(NSInteger)price nextBid:(NSInteger)bid;
{
  return [[[SniperSnapshot alloc] initWithAuctionID:auctionID lastPrice:price lastBid:bid state:SniperStateBidding] autorelease];
}

- (id)winning:(NSInteger)price currentBid:(NSInteger)bid;
{
  return [[[SniperSnapshot alloc] initWithAuctionID:auctionID lastPrice:price lastBid:bid state:SniperStateWinning] autorelease];
}

- (id)closed;
{
  return [[[SniperSnapshot alloc] initWithAuctionID:auctionID lastPrice:lastPrice lastBid:lastBid state:[self stateWhenClosed]] autorelease];
}

- (SniperState)stateWhenClosed;
{
  if (self.state == SniperStateWinning) {
    return SniperStateWon;
  }
  if (self.state == SniperStateWon || self.state == SniperStateLost) {
    @throw NSInternalInconsistencyException;
  }
  return SniperStateLost;
}

@end


