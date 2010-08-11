//
//  AuctionSniperViewController.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionSniperListener.h"

@class AuctionSniper;
@class AuctionSnipersDataSource;
@class SnipersTableModel;

@interface AuctionSniperViewController : UITableViewController <LRTableModelCellProvider, LRTableModelEventListener> {
  SnipersTableModel *snipers;
}
@property (nonatomic, readonly) SnipersTableModel *snipers;
@property (nonatomic, assign) IBOutlet AuctionSniperCell *cellPrototype;

- (void)setAuctionSniper:(AuctionSniper *)sniper;
@end
