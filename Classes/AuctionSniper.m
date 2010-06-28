//
//  AuctionSniper.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSniper.h"


@implementation AuctionSniper

- (id)initWithSniperListener:(id<AuctionSniperListener>)listener;
{
  if (self = [super init]) {
    sniperListener = listener;
  }
  return self;
}

#pragma mark -
#pragma mark Auction events

- (void)auctionClosed;
{
  [sniperListener auctionSniperLost];
}

- (void)currentPriceForAuction:(NSInteger)price increment:(NSInteger)increment;
{
 
}

@end
