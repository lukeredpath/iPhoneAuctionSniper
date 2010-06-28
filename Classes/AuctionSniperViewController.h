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

@interface AuctionSniperViewController : UIViewController <AuctionSniperListener> {
  UILabel *stateLabel;
  AuctionSniper *auctionSniper;
}
@property (nonatomic, retain) IBOutlet UILabel *stateLabel;
@property (nonatomic, retain) AuctionSniper *auctionSniper;
@end
