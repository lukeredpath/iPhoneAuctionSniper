//
//  AuctionSniperViewController.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSniperViewController.h"
#import "AuctionSniper.h"
#import "AuctionSnipersDataSource.h"
#import "SnipersTableModel.h"

#pragma mark -

@implementation AuctionSniperViewController

@synthesize snipers;
@synthesize cellPrototype;

static NSArray *STATE_LABELS = [[NSArray alloc] initWithObjects:
    @"Joining",
    @"Bidding",
    @"Winning",
    @"Won",
    @"Lost", nil];

- (void)dealloc 
{
  [cellPrototype release];
  [snipers release];
  [super dealloc];
}

- (void)awakeFromNib;
{
  snipers = [[SnipersTableModel alloc] initWithCellProvider:self];
  self.tableView.dataSource = self.snipers;
}

- (void)setAuctionSniper:(AuctionSniper *)sniper;
{
  [snipers setSniper:sniper];
}

- (void)viewDidLoad 
{
  [super viewDidLoad];
  
  self.tableView.rowHeight = 60;
}

- (void)viewDidUnload 
{
  [super viewDidUnload];
}

- (void)tableModelChanged:(LRTableModelEvent *)changeEvent
{
  [self.tableView reloadRowsAtIndexPaths:changeEvent.indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (void)cellForObjectAtIndexPath:(*)indexPath reuseIdentifier:(*)reuseIdentifier
{
  if (self.cellPrototype) {
    self.cellPrototype = nil;
  }
  [[UINib nibWithNibName:@"AuctionSniperCell" bundle:nil] instantiateWithOwner:self options:nil];

  return self.cellPrototype;
}

- (void)configureCell:(*)cell forObject:(id)object atIndexPath:(*)indexPath
{
  SniperSnapshot *snapshot = object;  
  [cell setAuctionID:snapshot.auctionID];
  [cell setStatus:[STATE_LABELS objectAtIndex:snapshot.state]];
  [cell setPrice:self.snapshot.lastPrice andBid:snapshot.lastBid];
}

@end
