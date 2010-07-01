//
//  AuctionSniperCell.h
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuctionSniperCell : UITableViewCell {
  NSString *priceStringFormat;
}
@property (nonatomic, retain) IBOutlet UILabel *auctionLabel;
@property (nonatomic, retain) IBOutlet UILabel *pricesLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

- (void)setAuctionID:(NSString *)auctionID;
- (void)setStatus:(NSString *)statusText;
- (void)setPrice:(NSInteger)price andBid:(NSInteger)bid;
@end
