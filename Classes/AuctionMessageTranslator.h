//
//  AuctionMessageTranslator.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPChatDelegate.h"
#import "AuctionEventListener.h"

@interface AuctionMessageTranslator : NSObject <XMPPChatDelegate> {
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

+ (id)auctionEventFromMessage:(NSString *)messageBody;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (AuctionPriceSource)isFromSniper:(NSString *)sniperID;
@end

