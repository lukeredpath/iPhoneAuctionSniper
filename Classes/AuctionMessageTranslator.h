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
  id<AuctionEventListener> auctionEventListener;
}
- (id)initWithAuctionEventListener:(id<AuctionEventListener>)listener;
@end

@interface AuctionEvent : NSObject
{
  NSDictionary *eventData;
}
@property (nonatomic, readonly) NSInteger currentPrice;
@property (nonatomic, readonly) NSInteger increment;
@property (nonatomic, readonly) NSString *type;

+ (id)auctionEventFromMessage:(NSString *)messageBody;
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end

