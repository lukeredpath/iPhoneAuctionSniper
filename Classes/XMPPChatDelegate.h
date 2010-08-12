//
//  XMPPChatDelegate.h
//  AuctionSniper
//
//  Created by Luke Redpath on 12/08/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMPPChatSession;
@class XMPPMessage;

@protocol XMPPChatDelegate
- (void)XMPPChatSession:(XMPPChatSession *)chatSession didReceiveMessage:(XMPPMessage *)message;
@end
