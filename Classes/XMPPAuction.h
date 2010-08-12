//
//  Auction.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Auction.h"

@class XMPPChatSession;

@interface XMPPAuction : NSObject <Auction> {
  XMPPChatSession *chatSession;
  NSString *itemID;
}
@property (nonatomic, readonly) NSString *itemID;

- (id)initWithChat:(XMPPChatSession *)chat itemID:(NSString *)theID;
- (void)join;
@end
