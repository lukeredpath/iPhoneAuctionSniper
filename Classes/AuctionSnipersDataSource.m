//
//  AuctionSnipersDataSource.m
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionSnipersDataSource.h"


@implementation AuctionSnipersDataSource

@synthesize statusText;

- (id)init;
{
  if (self = [super init]) {
    snipers = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)addSniper:(AuctionSniper *)sniper
{
  [snipers addObject:sniper];
}

- (AuctionSniper *)sniperForCellAtIndexPath:(NSIndexPath *)indexPath;
{
  return [snipers objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
  return [snipers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"AuctionSniperCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  cell.textLabel.text = self.statusText;
  
  return cell;
}

@end
