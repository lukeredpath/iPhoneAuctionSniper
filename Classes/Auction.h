//
//  Auction.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMPPStream;

@interface Auction : NSObject {
  XMPPStream *stream;
}
- (id)initWithStream:(XMPPStream *)aStream;
- (void)bid:(NSInteger)amount;
@end
