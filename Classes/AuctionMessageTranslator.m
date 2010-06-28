//
//  AuctionMessageTranslator.m
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "AuctionMessageTranslator.h"
#import "XMPPMessage.h"
#import "NSXMLElementAdditions.h"


@implementation AuctionMessageTranslator

- (id)initWithAuctionEventListener:(id<AuctionEventListener>)listener;
{
  if (self = [super init]) {
    auctionEventListener = listener;
  }
  return self;
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
  AuctionEvent *event = [AuctionEvent auctionEventFromMessage:[[message elementForName:@"body"] stringValue]];
  
  if ([event.type isEqualToString:@"CLOSE"]) {
    [auctionEventListener auctionClosed];
  }
  if ([event.type isEqualToString:@"PRICE"]) {
    [auctionEventListener currentPriceForAuction:event.currentPrice increment:event.increment];
  }
}

@end

@implementation AuctionEvent

NSString *trimString(NSString *string) {
  NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
  return [string stringByTrimmingCharactersInSet:charSet];
}

+ (id)auctionEventFromMessage:(NSString *)messageBody;
{
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  
  for (NSString *valuePair in [trimString(messageBody) componentsSeparatedByString:@";"]) {
    if (![valuePair isEqualToString:@""]) {
      NSArray *components = [valuePair componentsSeparatedByString:@":"];
      NSAssert1(components.count == 2, @"Expected components %@ to have 2 elements", components);
      
      [params setObject:trimString([components objectAtIndex:1]) forKey:trimString([components objectAtIndex:0])];
    }
  }
  return [[[self alloc] initWithDictionary:params] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dictionary;
{
  if (self = [super init]) {
    eventData = [dictionary copy];
  }
  return self;
}

- (void)dealloc;
{
  [eventData release];
  [super dealloc];
}

- (NSInteger)currentPrice;
{
  return [[eventData valueForKey:@"CurrentPrice"] integerValue];
}

- (NSInteger)increment;
{
  return [[eventData valueForKey:@"Increment"] integerValue];
}

- (NSString *)type;
{
  return [eventData valueForKey:@"Event"];
}

@end


