//
//  AuctionSniperViewController.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSniperViewController.h"
#import "AuctionSniper.h"

@interface AuctionSniperViewController ()
- (void)setState:(NSString *)state;
@end

#pragma mark -

@implementation AuctionSniperViewController

@synthesize stateLabel;
@synthesize auctionSniper;

- (void)dealloc 
{
  [auctionSniper release];
  [super dealloc];
}

- (void)setAuctionSniper:(AuctionSniper *)sniper;
{
  [auctionSniper autorelease];
  auctionSniper = [sniper retain];
  auctionSniper.delegate = self;
}

- (void)viewDidLoad 
{
  [super viewDidLoad];
  
  
}

- (void)setState:(NSString *)state;
{
  self.stateLabel.text = state;
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
