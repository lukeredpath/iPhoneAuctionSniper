//
//  AuctionSniperViewController.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuctionSniperViewController : UIViewController {
  UILabel *stateLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *stateLabel;

- (void)setState:(NSString *)state;
@end
