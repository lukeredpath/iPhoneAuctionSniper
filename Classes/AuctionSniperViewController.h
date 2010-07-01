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

@interface AuctionSniperViewController : UITableViewController <AuctionSniperListener> {

}
@property (nonatomic, retain) IBOutlet AuctionSnipersDataSource *dataSource;

- (void)setAuctionSniper:(AuctionSniper *)sniper;
@end
