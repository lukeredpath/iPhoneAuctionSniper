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

#pragma mark -

#define kAUCTION_ID 1
#define kAUCTION_RESOURCE @"auction"

@implementation XMPPAuction

- (id)initWithStream:(XMPPStream *)aStream;
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

- (void)bid:(NSInteger)amount;
{
  NSString *bidMessage = [NSString stringWithFormat:@"SOLVersion: 1.1; Command: BID; Price: %d;", amount];
  [self sendMessage:bidMessage];
}

@end

@implementation XMPPAuction (Messaging)

XMPPJID *_auctionJID(XMPPStream *stream, NSString *resource, NSInteger auctionID) {
  NSString *auctionUser = [NSString stringWithFormat:@"auction-item-%d", auctionID];
  return [XMPPJID jidWithUser:auctionUser domain:stream.hostName resource:resource];
}

- (void)sendMessage:(NSString *)messageBody;
{
  NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
  [body setStringValue:messageBody];
  
  NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
  [message addAttributeWithName:@"type" stringValue:@"chat"];
  [message addAttributeWithName:@"to" stringValue:_auctionJID(stream, kAUCTION_RESOURCE, kAUCTION_ID).full];
  [message addChild:body]; 
  
  [stream sendElement:message];
}

@end
