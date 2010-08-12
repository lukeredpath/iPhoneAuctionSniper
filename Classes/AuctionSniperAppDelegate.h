//
//  AuctionSniperAppDelegate.h
//  AuctionSniper
//
//  Created by Luke Redpath on 23/06/2010.
//  Copyright LJR Software Limited 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPStream.h"

@class AuctionSniperViewController;
@class AuctionMessageTranslator;
@class XMPPAuction;

@interface AuctionSniperAppDelegate : NSObject <UIApplicationDelegate, XMPPStreamDelegate> {
  UIWindow *window;
  AuctionSniperViewController *auctionSniperController;
  NSMutableArray *auctions;
  NSMutableArray *translators;
  XMPPStream *XMPPStreamForAuctionServer;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AuctionSniperViewController *auctionSniperController;
@property (nonatomic, readonly) XMPPStream *XMPPStreamForAuctionServer;

- (void)joinAuctionForItem:(NSString *)itemID;
@end

