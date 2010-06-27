//
//  AuctionSniperAppDelegate.h
//  AuctionSniper
//
//  Created by Luke Redpath on 23/06/2010.
//  Copyright LJR Software Limited 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuctionSniperAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)testAction;
@end

