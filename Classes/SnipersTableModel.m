//
//  SnipersTableModel.m
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "SnipersTableModel.h"
#import "LRAbstractTableModel+Extensions.h"
#import "AuctionSniper.h"

@implementation SnipersTableModel

@synthesize snapshot;

- (void)dealloc
{
  [snapshot release];
  [super dealloc];
}

- (void)setSniper:(AuctionSniper *)sniper;
{
  self.snapshot = [sniper currentSnapshot];
  [self fireTableRowsUpdated:[NSIndexSet indexSetWithIndex:0]];
  sniper.delegate = self;
}

- (void)auctionSniperChanged:(SniperSnapshot *)newSnapshot
{
  self.snapshot = newSnapshot;
  [self fireTableRowsUpdated:[NSIndexSet indexSetWithIndex:0]];
}

@end
