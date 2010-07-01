//
//  AuctionSniper.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuctionEventListener.h"
#import "AuctionSniperListener.h"
#import "Auction.h"

@class XMPPAuction;

typedef enum {
  SniperStateJoining = 0,
  SniperStateBidding,
  SniperStateWinning,
  SniperStateWon,
  SniperStateLost
} SniperState;

@interface AuctionSniper : NSObject <AuctionEventListener> {
  XMPPAuction *auction;
  id<AuctionSniperListener> delegate;
  SniperState state;
}
- (id)initWithAuction:(XMPPAuction *)anAuction;

@property (nonatomic, readonly) id<Auction> auction;
@property (nonatomic, assign) id<AuctionSniperListener> delegate;
@end

@interface SniperSnapshot : NSObject
{
  NSString *auctionID;
  NSInteger lastPrice;
  NSInteger lastBid;
  SniperState state;
}
@property (nonatomic, readonly) NSInteger lastPrice;
@property (nonatomic, readonly) NSInteger lastBid;
@property (nonatomic, readonly) SniperState state;

- (id)initWithAuctionID:(NSString *)auctionID lastPrice:(NSInteger)price lastBid:(NSInteger)bid state:(SniperState)sniperState;
- (BOOL)isEqualToSnapshot:(SniperSnapshot *)snapshot;
- (BOOL)isForSameAuction:(NSString *)anAuctionID;
@end
