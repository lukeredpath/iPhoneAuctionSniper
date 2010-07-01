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

@interface AuctionSniperViewController ()
- (void)setState:(NSString *)state;
@end

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
  [self.dataSource addSniper:sniper];
  [self setState:@"Joining"];

  NSIndexPath *sniperIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:sniperIndexPath] withRowAnimation:UITableViewRowAnimationFade];
  
  sniper.delegate = self;
}

- (void)viewDidLoad 
{
  [super viewDidLoad];
  
  self.tableView.rowHeight = 60;
}

- (void)setState:(NSString *)state;
{
  self.dataSource.statusText = state;
  NSIndexPath *sniperIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:sniperIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidUnload 
{
  [super viewDidUnload];
}

#pragma mark -
#pragma mark Sniper events

- (void)auctionSniperLost;
{
  [self setState:@"Lost"];
}

- (void)auctionSniperBidding;
{
  [self setState:@"Bidding"];
}

- (void)auctionSniperWinning;
{
  [self setState:@"Winning"];
}

- (void)auctionSniperWon;
{
  [self setState:@"Won"];
}

@end
