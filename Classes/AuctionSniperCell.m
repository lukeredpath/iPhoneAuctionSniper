//
//  AuctionSniperCell.m
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSniperCell.h"
#import "AuctionSniper.h"
#import "Auction.h"

@implementation AuctionSniperCell

@synthesize pricesLabel;
@synthesize auctionLabel;
@synthesize statusLabel;

- (void)dealloc;
{
  [priceStringFormat release];
  [auctionLabel release];
  [pricesLabel release];
  [statusLabel release];
  [super dealloc];
}

- (void)awakeFromNib;
{
  priceStringFormat = [pricesLabel.text copy];
}

- (void)setAuctionID:(NSString *)auctionID;
{
  auctionLabel.text = auctionID;
}

- (void)setStatus:(NSString *)statusText;
{
  statusLabel.text = statusText;
}

- (void)setPrice:(NSInteger)price andBid:(NSInteger)bid;
{
  pricesLabel.text = [NSString stringWithFormat:priceStringFormat, price, bid];
}

@end
