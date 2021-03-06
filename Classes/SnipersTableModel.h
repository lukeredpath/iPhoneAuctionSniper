//
//  SnipersTableModel.h
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRAbstractTableModel.h"
#import "AuctionSniperListener.h"

@class SniperSnapshot;
@class AuctionSniper;

@interface SnipersTableModel : LRAbstractTableModel <AuctionSniperListener> {
  SniperSnapshot *snapshot;
}
@property (nonatomic, retain) SniperSnapshot *snapshot;

- (void)setSniper:(AuctionSniper *)sniper;
@end
