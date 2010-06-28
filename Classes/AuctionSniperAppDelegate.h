//
//  AuctionSniperAppDelegate.h
//  AuctionSniper
//
//  Created by Luke Redpath on 23/06/2010.
//  Copyright LJR Software Limited 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPStream.h"
#import "AuctionEventListener.h"

@class AuctionSniperViewController;
@class AuctionMessageTranslator;

@interface AuctionSniperAppDelegate : NSObject <UIApplicationDelegate, XMPPStreamDelegate, AuctionEventListener> {
  UIWindow *window;
  AuctionSniperViewController *auctionSniperController;
  AuctionMessageTranslator *messageTranslator;
  XMPPStream *xmppStream;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AuctionSniperViewController *auctionSniperController;
@end

