//
//  SniperStateWith.h
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OCHamcrest/HCDescription.h>
#import <OCHamcrest/HCBaseMatcher.h>

@interface SniperStateWith : HCBaseMatcher
{
  NSInteger _price;
  NSInteger _bid;
}
- (id)initWithPrice:(NSInteger)price bid:(NSInteger)bid;
+ (id)sniperStateWithPrice:(NSInteger)price bid:(NSInteger)bid;
@end

#ifdef __cplusplus
extern "C" {
#endif
  id<HCMatcher> HC_sniperStateWith();
#ifdef __cplusplus
}
#endif

#ifdef HC_SHORTHAND
#define sniperStateWith HC_sniperStateWith
#endif