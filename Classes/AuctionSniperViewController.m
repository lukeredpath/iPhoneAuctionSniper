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
#import "AuctionSniperCell.h"

#pragma mark -

@implementation AuctionSniperViewController

@synthesize snipers;
@synthesize cellPrototype;

- (void)dealloc 
{
  [cellPrototype release];
  [snipers release];
  [super dealloc];
}

- (void)awakeFromNib;
{
  snipers = [[SnipersTableModel alloc] initWithCellProvider:self];
  [snipers addTableModelListener:self];
  
  self.tableView.dataSource = self.snipers;
}

- (void)addSniper:(AuctionSniper *)sniper;
{
  [snipers addSniper:sniper];
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
  //[self.tableView reloadRowsAtIndexPaths:changeEvent.indexPaths withRowAnimation:UITableViewRowAnimationNone];
  [self.tableView reloadData];
}

- (NSString *)cellReuseIdentifierForIndexPath:(NSIndexPath *)indexPath
{
  return @"AuctionSniperCell";
}

- (UITableViewCell *)cellForObjectAtIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self.cellPrototype) {
    self.cellPrototype = nil;
  }
  [[UINib nibWithNibName:@"AuctionSniperCell" bundle:nil] instantiateWithOwner:self options:nil];

  return (UITableViewCell *)self.cellPrototype;
}

- (void)configureCell:(UITableViewCell *)cell forObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
  SniperSnapshot *snapshot = object;  
  AuctionSniperCell *sniperCell = (AuctionSniperCell *)cell;
  
  [sniperCell setAuctionID:snapshot.auctionID];
  [sniperCell setStatus:[self.snipers labelForState:snapshot.state]];
  [sniperCell setPrice:snapshot.lastPrice andBid:snapshot.lastBid];
}

@end
