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
    [auction bid:(price + increment)];
    [self.delegate auctionSniperBidding];
  }
}

@end
