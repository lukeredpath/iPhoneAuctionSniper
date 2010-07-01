//
//  SniperStateWith.m
//  AuctionSniper
//
//  Created by Luke Redpath on 01/07/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "SniperStateWith.h"
#import "AuctionSniper.h"

@implementation SniperStateWith

- (id)initWithPrice:(NSInteger)price bid:(NSInteger)bid;
{
  if (self = [super init]) {
    _price = price;
    _bid = bid;
  }
  return self;
}

- (BOOL)matches:(id)item
{  
  if (![item isKindOfClass:[SniperState class]]) {
    return NO;
  }
  SniperState *state = (SniperState *)item;
  
  NSLog(@"PRICE: %d BID: %d", state.lastPrice, state.lastBid);

  return (state.lastPrice == _price && state.lastBid == _bid);
}

- (void)describeTo:(id <HCDescription>)description
{
  [description appendText:[NSString stringWithFormat:@" whose price is %d and bid is %d", _price, _bid]];
}

+ (id)sniperStateWithPrice:(NSInteger)price bid:(NSInteger)bid
{
  return [[[self alloc] initWithPrice:price bid:bid] autorelease];
}

@end

#ifdef __cplusplus
extern "C" {
#endif
  id<HCMatcher> HC_sniperStateWith(NSInteger price, NSInteger bid) {
    return [SniperStateWith sniperStateWithPrice:price bid:bid];
  }
#ifdef __cplusplus
}
#endif