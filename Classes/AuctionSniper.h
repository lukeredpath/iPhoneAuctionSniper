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

@property (nonatomic, assign) id<AuctionSniperListener> delegate;
@end
