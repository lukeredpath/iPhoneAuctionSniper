//
//  AuctionSniperViewController.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSniperViewController.h"


@implementation AuctionSniperViewController

@synthesize stateLabel;

- (void)dealloc 
{
  [super dealloc];
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

@end
