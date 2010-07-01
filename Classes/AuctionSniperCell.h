//
//  AuctionSniperCell.h
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuctionSniper;

@interface AuctionSniperCell : UITableViewCell {
  NSString *priceStringFormat;
}
@property (nonatomic, retain) IBOutlet UILabel *auctionLabel;
@property (nonatomic, retain) IBOutlet UILabel *pricesLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

- (void)updateWithAuctionSniper:(AuctionSniper *)auctionSniper status:(NSString *)statusString;
@end
