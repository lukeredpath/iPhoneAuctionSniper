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

@interface SnipersTableModel ()
- (int)rowMatching:(SniperSnapshot *)snapshot;
@end

@implementation SnipersTableModel

static NSArray *STATE_LABELS;

- (void)dealloc
{
  [snapshots release];
  [super dealloc];
}

- (id)initWithCellProvider:(id <LRTableModelCellProvider>)theCellProvider
{
  if (self = [super initWithCellProvider:theCellProvider]) {
    snapshots = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)addSniper:(AuctionSniper *)sniper;
{
  [snapshots addObject:sniper.currentSnapshot];
  [sniper setDelegate:self];
  [self fireTableRowsInserted:[NSIndexSet indexSetWithIndex:snapshots.count-1] inSection:0];
}

- (void)auctionSniperChanged:(SniperSnapshot *)snapshot
{
  int rowForSnapshot = [self rowMatching:snapshot];
  [snapshots replaceObjectAtIndex:rowForSnapshot withObject:snapshot];
  [self fireTableRowsUpdated:[NSIndexSet indexSetWithIndex:rowForSnapshot] inSection:0];
}

- (NSString *)labelForState:(SniperState)state
{
  if (STATE_LABELS == nil) {
    STATE_LABELS = [[NSArray alloc] initWithObjects:
      @"Joining", @"Bidding", @"Winning", @"Won", @"Lost", nil];
  }
  return [STATE_LABELS objectAtIndex:state];
}

- (NSInteger)numberOfSections
{
  return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex
{
  return snapshots.count;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
  return [snapshots objectAtIndex:indexPath.row];
}

- (int)rowMatching:(SniperSnapshot *)snapshot;
{
  for (int i = 0; i < snapshots.count; i++) {
    if ([snapshot isForSameItemAs:[snapshots objectAtIndex:i]]) {
      return i;
    }
  }
  @throw NSInternalInconsistencyException;
}

@end
