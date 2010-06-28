//
//  XMPPAuctionTest.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "TestingCommon.h"
#import "XMPPAuction.h"
#import "XMPPStream.h"
#import "NSXMLElementAdditions.h"
#import <OCHamcrest/HCDescription.h>

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

@interface XMPPAuctionTest : SenTestCase
{
  XMPPAuction *auction;
  id stream;
}
@property (nonatomic, retain) XMPPAuction *auction;
@property (nonatomic, retain) id stream;
@end

@implementation XMPPAuctionTest

@synthesize auction, stream;

- (void)setUp;
{
  self.stream  = [OCMockObject mockForClass:[XMPPStream class]];
  self.auction = [[[XMPPAuction alloc] initWithStream:stream] autorelease];
  
  [[[self.stream stub] andReturn:@"localhost"] hostName];
}

- (void)testSendsBidMessageWithPriceWhenBidding;
{
  [[self.stream expect] sendElement:(id)hasMessageBody(allOf(
    containsString(@"Command: BID"), 
    containsString(@"Price: 50"), nil))];
  
  [self.auction bid:50];
}

- (void)testSendsJoinCommandWhenJoining;
{
  [[self.stream expect] sendElement:(id)hasMessageBody(containsString(@"Command: JOIN"))];
  [self.auction join];
}

@end
