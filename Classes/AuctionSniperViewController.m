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
- (void)setState:(NSString *)state snapshot:(SniperSnapshot *)snapshot;
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
  SniperSnapshot *defaultSnapshot = [[SniperSnapshot alloc] initWithAuctionID:sniper.auctionID lastPrice:0 lastBid:0 state:SniperStateJoining];
  [self setState:@"Joining" snapshot:defaultSnapshot];
  [defaultSnapshot release];

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
  [self setState:state snapshot:nil];
}

- (void)setState:(NSString *)state snapshot:(SniperSnapshot *)snapshot;
{
  [self.dataSource updateSniper:snapshot statusText:state];
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

- (void)auctionSniperBidding:(SniperSnapshot *)snapshot;
{
  [self setState:@"Bidding" snapshot:snapshot];
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
