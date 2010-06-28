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
#import "ElementHasMessageBody.h"

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
