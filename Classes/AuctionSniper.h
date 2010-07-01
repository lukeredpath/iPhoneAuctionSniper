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
  NSString *auctionID;
  id<AuctionSniperListener> delegate;
  SniperSnapshot *currentSnapshot;
}
@property (nonatomic, readonly) id<Auction> auction;
@property (nonatomic, readonly) NSString *auctionID;
@property (nonatomic, assign) id<AuctionSniperListener> delegate;
@property (nonatomic, retain, readonly) SniperSnapshot *currentSnapshot;

- (id)initWithAuction:(XMPPAuction *)anAuction auctionID:(NSString *)anAuctionID;
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
@property (nonatomic, readonly) NSString *auctionID;

- (id)initWithAuctionID:(NSString *)auctionID lastPrice:(NSInteger)price lastBid:(NSInteger)bid state:(SniperState)sniperState;
- (BOOL)isEqualToSnapshot:(SniperSnapshot *)snapshot;
- (BOOL)isForSameAuction:(NSString *)anAuctionID;
- (SniperState)stateWhenClosed;
@end
