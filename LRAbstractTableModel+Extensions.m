//
//  LRAbstractTableModel+Extensions.m
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "LRAbstractTableModel+Extensions.h"


@implementation LRAbstractTableModel (Extensions)

- (void)fireTableRowsUpdated:(NSIndexSet *)indices
{
  [indices enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
    [self notifyListeners:[LRTableModelEvent updatedRow:index section:0]];
  }];
}

@end
