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

@class Auction;

@interface AuctionSniper : NSObject <AuctionEventListener> {
  Auction *auction;
  id<AuctionSniperListener> delegate;
}
- (id)initWithAuction:(Auction *)anAuction;

@property (nonatomic, assign) id<AuctionSniperListener> delegate;
@end
