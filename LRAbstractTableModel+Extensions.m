//
//  LRAbstractTableModel+Extensions.m
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "LRAbstractTableModel+Extensions.h"


@implementation LRAbstractTableModel (Extensions)

- (void)fireTableRowsInserted:(NSIndexSet *)indices inSection:(NSInteger)sectionIndex;
{
  [indices enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
    [self notifyListeners:[LRTableModelEvent insertionAtRow:index section:sectionIndex]];
  }];
}

- (void)fireTableRowsUpdated:(NSIndexSet *)indices inSection:(NSInteger)sectionIndex;
{
  [indices enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
    [self notifyListeners:[LRTableModelEvent updatedRow:index section:sectionIndex]];
  }];
}

@end
