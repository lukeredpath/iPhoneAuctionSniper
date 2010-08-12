//
//  LRAbstractTableModel+Extensions.h
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRAbstractTableModel.h"

@interface LRAbstractTableModel (Extension)

- (void)fireTableRowsInserted:(NSIndexSet *)indices inSection:(NSInteger)sectionIndex;
- (void)fireTableRowsUpdated:(NSIndexSet *)indices inSection:(NSInteger)sectionIndex;

@end
