//
//  Auction.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "XMPPAuction.h"
#import "XMPPChatSession.h"

@implementation XMPPAuction

@synthesize itemID;

- (id)initWithChat:(XMPPChatSession *)chat itemID:(NSString *)theID;
{
  if (self = [super init]) {
    chatSession = [chat retain];
    itemID = [theID copy];
  }
  return self;
}

- (void)dealloc;
{
  [itemID release];
  [chatSession release];
  [super dealloc];
}

- (void)join;
{
  [chatSession sendMessage:@"SOLVersion: 1.1; Command: JOIN;"];
}

- (void)bid:(NSInteger)amount;
{
  [chatSession sendMessage:[NSString stringWithFormat:@"SOLVersion: 1.1; Command: BID; Price: %d;", amount]];
}

@end

