//
//  Auction.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Auction.h"

@class XMPPStream;

@interface XMPPAuction : NSObject <Auction> {
  XMPPStream *stream;
}
- (id)initWithStream:(XMPPStream *)aStream;
@end
