//
//  ElementHasMessageBody.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OCHamcrest/HCDescription.h>
#import <OCHamcrest/HCBaseMatcher.h>

@interface ElementHasMessageBody : HCBaseMatcher
{
  id<HCMatcher>matcher;
  NSString *bodyString;
  NSString *receivedMessageBody;
}
- (id)initWithString:(NSString *)aString;
- (id)initWithMatcher:(id<HCMatcher>)aMatcher;
+ (id)elementHasMessageBody:(id)stringOrMatcher;
@end

#ifdef __cplusplus
extern "C" {
#endif
  id<HCMatcher> HC_hasMessageBody();
#ifdef __cplusplus
}
#endif

#ifdef HC_SHORTHAND
#define hasMessageBody HC_hasMessageBody
#endif

