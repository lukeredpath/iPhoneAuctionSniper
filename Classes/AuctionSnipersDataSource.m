//
//  AuctionSnipersDataSource.m
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSnipersDataSource.h"
#import "AuctionSniperCell.h"
#import "AuctionSniper.h"

@interface AuctionSnipersDataSource ()
@property (nonatomic, retain) SniperSnapshot *snapshot;
@end

@implementation AuctionSnipersDataSource

@synthesize snapshot;
@synthesize cellPrototype;

static NSArray *sniperStateLabels = nil;

+ (void)initialize;
{
  [super initialize];
  
  if (sniperStateLabels == nil) {
    sniperStateLabels = [[NSArray alloc] initWithObjects:
                         @"Joining",
                         @"Bidding",
                         @"Winning",
                         @"Won",
                         @"Lost", nil];
  }
}

- (void)updateSniper:(SniperSnapshot *)sniperSnapshot;
{
  self.snapshot = sniperSnapshot;
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"AuctionSniperCell";
  
  AuctionSniperCell *cell = (AuctionSniperCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    [[UINib nibWithNibName:@"AuctionSniperCell" bundle:nil] instantiateWithOwner:self options:nil];
    cell = self.cellPrototype;
    self.cellPrototype = nil;
  }
  [cell setAuctionID:self.snapshot.auctionID];
  [cell setStatus:[sniperStateLabels objectAtIndex:self.snapshot.state]];
  [cell setPrice:self.snapshot.lastPrice andBid:self.snapshot.lastBid];
  
  return cell;
}

@end
