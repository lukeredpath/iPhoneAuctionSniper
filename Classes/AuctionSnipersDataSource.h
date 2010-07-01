//
//  AuctionSnipersDataSource.h
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuctionSniper;

@interface AuctionSnipersDataSource : NSObject <UITableViewDataSource> {
  NSMutableArray *snipers;
}
@property (nonatomic, copy) NSString *statusText;

- (void)addSniper:(AuctionSniper *)sniper;
- (AuctionSniper *)sniperForCellAtIndexPath:(NSIndexPath *)indexPath;
@end
