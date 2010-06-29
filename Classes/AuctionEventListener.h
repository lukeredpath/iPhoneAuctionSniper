//
//  AuctionEventListener.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

typedef enum {
  PriceFromSniper = 0,
  PriceFromOtherBidder
} AuctionPriceSource;

@protocol AuctionEventListener
- (void)auctionClosed;
- (void)currentPriceForAuction:(NSInteger)price increment:(NSInteger)increment priceSource:(AuctionPriceSource)priceSource;
@end
