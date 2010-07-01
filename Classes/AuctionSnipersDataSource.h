//
//  AuctionSnipersDataSource.h
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuctionSniper;
@class AuctionSniperCell;

@interface AuctionSnipersDataSource : NSObject <UITableViewDataSource> {
  NSMutableArray *snipers;
}
@property (nonatomic, copy) NSString *statusText;
@property (nonatomic, assign) IBOutlet AuctionSniperCell *cellPrototype;

- (void)addSniper:(AuctionSniper *)sniper;
- (AuctionSniper *)sniperForCellAtIndexPath:(NSIndexPath *)indexPath;
@end
