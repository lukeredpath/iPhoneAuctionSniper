//
//  XMPPChatSession.m
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "XMPPChatSession.h"
#import "XMPP.h"

@implementation XMPPChatSession

@synthesize delegate;

- (id)initWithStream:(XMPPStream *)aStream userJID:(XMPPJID *)JID;
{
  if (self = [super init]) {
    stream = [aStream retain];
    userJID = [JID retain];

    [stream addDelegate:self];
    [self subscribe];
  }
  return self;
}

- (void)dealloc
{
  [stream removeDelegate:self];
  [stream release];
  [userJID release];
  [super dealloc];
}

- (void)subscribe
{
  NSXMLElement *presence = [NSXMLElement elementWithName:@"presence"];
  [stream sendElement:presence];
  [presence addAttributeWithName:@"to" stringValue:userJID.bare];
	[presence addAttributeWithName:@"type" stringValue:@"subscribed"];
  [stream sendElement:presence];
}

- (void)sendMessage:(NSString *)messageBody;
{
  NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
  [body setStringValue:messageBody];
  NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
  [message addAttributeWithName:@"type" stringValue:@"chat"];
  [message addAttributeWithName:@"to" stringValue:userJID.bare];
  [message addChild:body]; 
  [stream sendElement:message];
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
  if ([message.from isEqual:userJID]) {
    [self.delegate XMPPChatSession:self didReceiveMessage:message];
  }
}

@end

@implementation XMPPStream (XMPPChatAdditions)

- (XMPPChatSession *)chatSessionWithUser:(XMPPJID *)userJID;
{
  return [[[XMPPChatSession alloc] initWithStream:self userJID:userJID] autorelease];
}

@end
