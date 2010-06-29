//
//  AuctionMessageTranslator.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPStream.h"
#import "AuctionEventListener.h"

@class XMPPMessage;

@interface AuctionMessageTranslator : NSObject <XMPPStreamDelegate> {
  NSString *sniperID;
  id<AuctionEventListener> auctionEventListener;
}
- (id)initWithSniperID:(NSString *)_sniperID eventListener:(id<AuctionEventListener>)listener;
@end

@interface AuctionEvent : NSObject
{
  NSDictionary *eventData;
}
@property (nonatomic, readonly) NSInteger currentPrice;
@property (nonatomic, readonly) NSInteger increment;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *bidder;

+ (id)auctionEventFromMessage:(NSString *)messageBody;
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end

