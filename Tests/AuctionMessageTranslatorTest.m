//
//  ASAuctionMessageTranslatorTest.m
//  AuctionSniper
//
//  Created by Luke Redpath on 23/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#define HC_SHORTHAND
#import <SenTestingKit/SenTestingKit.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMock/OCMock.h>

#import "AuctionMessageTranslator.h"
#import "XMPPMessage.h"
#import "NSXMLElementAdditions.h"

@interface AuctionMessageTranslatorTest : SenTestCase {
  AuctionMessageTranslator *translator;
  id listener;
}
@property (nonatomic, retain) AuctionMessageTranslator *translator;
@property (nonatomic, retain) id listener;
@end

#pragma mark -

XMPPMessage *createMessageWithBody(NSString *body) {
  NSXMLElement *bodyElement = [NSXMLElement elementWithName:@"body"];
  [bodyElement setStringValue:body];
  
  NSXMLElement *messageElement = [NSXMLElement elementWithName:@"message"];
  [messageElement addAttributeWithName:@"type" stringValue:@"chat"];
  [messageElement addChild:bodyElement];
  
  return [XMPPMessage messageFromElement:messageElement];
}

@implementation AuctionMessageTranslatorTest

@synthesize translator;
@synthesize listener;

static id UNUSED_STREAM = nil;

- (void)setUp;
{
  self.listener   = [OCMockObject mockForProtocol:@protocol(AuctionEventListener)];
  self.translator = [[[AuctionMessageTranslator alloc] initWithAuctionEventListener:self.listener] autorelease];
}

- (void)tearDown;
{
  [self.listener verify];
}

- (void)testNotifiesAuctionClosedWhenCloseMessageReceived;
{
  [[self.listener expect] auctionClosed];
  
  XMPPMessage *message = createMessageWithBody(@"SOLVersion: 1.1; Event: CLOSE");
  [translator xmppStream:UNUSED_STREAM didReceiveMessage:message];
}

- (void)testNotifiesBidDetailsWhenCurrentPriceMessageReceived;
{
  [[self.listener expect] currentPriceForAuction:192 increment:7];
  
  XMPPMessage *message = createMessageWithBody(@"SOLVersion: 1.1; Event: PRICE; CurrentPrice: 192; Increment: 7; Bidder: Someone else;");
  [translator xmppStream:UNUSED_STREAM didReceiveMessage:message];
}

@end


