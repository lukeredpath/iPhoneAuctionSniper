//
//  AuctionSnipersDataSource.h
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuctionSniperCell;
@class SniperSnapshot;

@interface AuctionSnipersDataSource : NSObject <UITableViewDataSource> {
}
@property (nonatomic, assign) IBOutlet AuctionSniperCell *cellPrototype;

- (void)updateSniper:(SniperSnapshot *)snapshot statusText:(NSString *)text;
@end
