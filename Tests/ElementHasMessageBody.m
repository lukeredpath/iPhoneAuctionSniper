//
//  ElementHasMessageBody.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "ElementHasMessageBody.h"
#import "NSXMLElementAdditions.h"

@implementation ElementHasMessageBody

- (id)initWithString:(NSString *)aString;
{
  if (self = [super init]) {
    bodyString = [aString copy];
  }
  return self;
}

- (id)initWithMatcher:(id<HCMatcher>)aMatcher;
{
  if (self = [super init]) {
    matcher = [aMatcher retain];
  }
  return self;
}

- (void)dealloc;
{
  [receivedMessageBody release];
  [bodyString release];
  [matcher release];
  [super dealloc];
}

- (BOOL)matches:(id)item
{  
  receivedMessageBody = [[[(NSXMLElement *)item elementForName:@"body"] stringValue] copy];
  
  if (matcher) {
    return [matcher matches:receivedMessageBody];
  }
  return [receivedMessageBody isEqualToString:bodyString];
}

- (void)describeTo:(id <HCDescription>)description
{
  if (bodyString) {
    [description appendText:[NSString stringWithFormat:@" with NSXMLElement that has a body matching %@", bodyString]];
  } else {
    [description appendText:@" whose body is "];
    [matcher describeTo:description];
  }
}

+ (id)elementHasMessageBody:(id)stringOrMatcher;
{
  if ([stringOrMatcher conformsToProtocol:@protocol(HCMatcher)]) {
    return [[[self alloc] initWithMatcher:stringOrMatcher] autorelease];
  }
  return [[self alloc] initWithString:stringOrMatcher];
}

@end

#ifdef __cplusplus
extern "C" {
#endif
  id<HCMatcher> HC_hasMessageBody(id matcherOrString) {
    return [ElementHasMessageBody elementHasMessageBody:matcherOrString];
  }
#ifdef __cplusplus
}
#endif