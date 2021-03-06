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
  AuctionMessageTranslator *messageTranslator;
  XMPPAuction *auction;
  XMPPStream *xmppStream;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AuctionSniperViewController *auctionSniperController;
@end

