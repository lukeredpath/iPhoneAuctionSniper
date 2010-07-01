//
//  SnapshotWithState.h
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OCHamcrest/HCDescription.h>
#import <OCHamcrest/HCBaseMatcher.h>
#import "AuctionSniper.h"

@interface SnapshotWithState : HCBaseMatcher
{
  SniperState snapshotState;
}
- (id)initWithState:(SniperState)state;
+ (id)snapshotWithState:(SniperState)state;
@end

#ifdef __cplusplus
extern "C" {
#endif
  id<HCMatcher> HC_snapshotWithState();
#ifdef __cplusplus
}
#endif

#ifdef HC_SHORTHAND
#define snapshotWithState HC_snapshotWithState
#endif
