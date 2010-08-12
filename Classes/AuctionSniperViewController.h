//
//  AuctionSniperViewController.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionSniperListener.h"
#import "LRTableModelCellProvider.h"
#import "LRTableModelEventListener.h"

@class AuctionSniper;
@class SnipersTableModel;
@class AuctionSniperCell;

@interface AuctionSniperViewController : UITableViewController <LRTableModelCellProvider, LRTableModelEventListener> {
  SnipersTableModel *snipers;
}
@property (nonatomic, readonly) SnipersTableModel *snipers;
@property (nonatomic, assign) IBOutlet AuctionSniperCell *cellPrototype;

- (void)addSniper:(AuctionSniper *)sniper;
@end
