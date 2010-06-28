//
//  AuctionSniper.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSniper.h"
#import "XMPPAuction.h"

@implementation AuctionSniper

@synthesize delegate;

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
  [self.delegate auctionSniperLost];
}

- (void)currentPriceForAuction:(NSInteger)price increment:(NSInteger)increment;
{
  [auction bid:(price + increment)];
  [self.delegate auctionSniperBidding];
}

@end
