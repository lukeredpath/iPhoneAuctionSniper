//
//  XMPPChatSession.h
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPStream.h"
#import "XMPPChatDelegate.h"

@interface XMPPChatSession : NSObject <XMPPStreamDelegate> {
  XMPPStream *stream;
  XMPPJID *userJID;
  id<XMPPChatDelegate> delegate;
}
@property (nonatomic, assign) id<XMPPChatDelegate> delegate;

- (id)initWithStream:(XMPPStream *)aStream userJID:(XMPPJID *)JID;
- (void)subscribe;
- (void)sendMessage:(NSString *)messageBody;
@end

@interface XMPPStream (XMPPChatAdditions)
- (XMPPChatSession *)chatSessionWithUser:(XMPPJID *)userJID;
@end
