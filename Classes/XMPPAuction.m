//
//  Auction.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "XMPPAuction.h"
#import "XMPP.h"

@interface XMPPAuction (Messaging)
- (void)sendMessage:(NSString *)messageBody;
@end

XMPPJID *auctionJID(XMPPStream *stream, NSString *resource, NSString *auctionID) {
  NSString *auctionUser = [NSString stringWithFormat:@"auction-%@", auctionID];
  return [XMPPJID jidWithUser:auctionUser domain:stream.hostName resource:resource];
}

#define kAUCTION_RESOURCE @"auction"

@implementation XMPPAuction

- (id)initWithStream:(XMPPStream *)aStream auctionID:(NSString *)auctionID;
{
  if (self = [super init]) {
    stream = [aStream retain];
  }
  return self;
}

- (void)dealloc;
{
  [stream release];
  [super dealloc];
}

- (void)join;
{
  [self sendMessage:@"SOLVersion: 1.1; Command: JOIN;"];
}

- (void)bid:(NSInteger)amount;
{
  [self sendMessage:[NSString stringWithFormat:@"SOLVersion: 1.1; Command: BID; Price: %d;", amount]];
}

- (void)subscribe;
{
  NSXMLElement *presence = [NSXMLElement elementWithName:@"presence"];
  [stream sendElement:presence];
  [presence addAttributeWithName:@"to" stringValue:auctionJID(stream, kAUCTION_RESOURCE, self.auctionID).bare];
	[presence addAttributeWithName:@"type" stringValue:@"subscribed"];
  [stream sendElement:presence];
}

- (void)subscribeAndJoin;
{
  [self subscribe];
  [self join];
}

@end

@implementation XMPPAuction (Messaging)

- (void)sendMessage:(NSString *)messageBody;
{
  NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
  [body setStringValue:messageBody];
  
  NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
  [message addAttributeWithName:@"type" stringValue:@"chat"];
  [message addAttributeWithName:@"to" stringValue:auctionJID(stream, kAUCTION_RESOURCE, self.auctionID).full];
  [message addChild:body]; 
  
  [stream sendElement:message];
}

@end
