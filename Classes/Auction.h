//
//  Auction.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Auction

- (void)join;
- (void)bid:(NSInteger)amount;
- (NSString *)auctionID;

@end
