//
//  AuctionSniperListener.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SniperSnapshot;

@protocol AuctionSniperListener

- (void)auctionSniperLost;
- (void)auctionSniperBidding:(SniperSnapshot *)snapshot;
- (void)auctionSniperWinning;
- (void)auctionSniperWon;

@end
