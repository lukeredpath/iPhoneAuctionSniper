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

#pragma mark -

@implementation AuctionSniperViewController

@synthesize dataSource;

- (void)dealloc 
{
  [dataSource release];
  [super dealloc];
}

- (void)awakeFromNib;
{
  self.dataSource = [[[AuctionSnipersDataSource alloc] init] autorelease];
  self.tableView.dataSource = self.dataSource;
}

- (void)setAuctionSniper:(AuctionSniper *)sniper;
{
  [self auctionSniperChanged:sniper.currentSnapshot];
  
  NSIndexPath *sniperIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:sniperIndexPath] withRowAnimation:UITableViewRowAnimationFade];
  
  sniper.delegate = self;
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

- (void)auctionSniperChanged:(SniperSnapshot *)snapshot;
{
  [self.dataSource updateSniper:snapshot];
  NSIndexPath *sniperIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:sniperIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
