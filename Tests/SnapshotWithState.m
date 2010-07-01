//
//  SnapshotWithState.m
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "SnapshotWithState.h"


@implementation SnapshotWithState

- (id)initWithState:(SniperState)state;
{
  if (self = [super init]) {
    snapshotState = state;
  }
  return self;
}

+ (id)snapshotWithState:(SniperState)state;
{
  return [[[self alloc] initWithState:state] autorelease];
}

- (BOOL)matches:(SniperSnapshot *)item
{  
  return item.state == snapshotState;
}

- (void)describeTo:(id <HCDescription>)description
{
  [description appendText:@" with the specified state"];
}

@end

#ifdef __cplusplus
extern "C" {
#endif
  id<HCMatcher> HC_snapshotWithState(SniperState state) {
    return [SnapshotWithState snapshotWithState:state];
  }
#ifdef __cplusplus
}
#endif