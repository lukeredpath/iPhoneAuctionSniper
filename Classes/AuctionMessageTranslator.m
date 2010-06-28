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

NSString *trimString(NSString *string) {
  NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
  return [string stringByTrimmingCharactersInSet:charSet];
}

@interface AuctionMessageTranslator (Parsing)
- (NSDictionary *)parseMessageBody:(NSString *)body;
@end

#pragma mark -

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
  NSDictionary *params = [self parseMessageBody:[[message elementForName:@"body"] stringValue]];
  NSString *eventType = [params valueForKey:@"Event"];
  
  if ([eventType isEqualToString:@"CLOSE"]) {
    [auctionEventListener auctionClosed];
  }
  if ([eventType isEqualToString:@"PRICE"]) {
    NSInteger currentPrice = [[params valueForKey:@"CurrentPrice"] intValue];
    NSInteger increment    = [[params valueForKey:@"Increment"] intValue];

    [auctionEventListener currentPriceForAuction:currentPrice increment:increment];
  }
}

@end

@implementation AuctionMessageTranslator (Parsing)

- (NSDictionary *)parseMessageBody:(NSString *)body;
{
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  
  for (NSString *valuePair in [trimString(body) componentsSeparatedByString:@";"]) {
    if (![valuePair isEqualToString:@""]) {
      NSArray *components = [valuePair componentsSeparatedByString:@":"];
      NSAssert1(components.count == 2, @"Expected components %@ to have 2 elements", components);
      
      [params setObject:trimString([components objectAtIndex:1]) forKey:trimString([components objectAtIndex:0])];
    }
  }
  return [[params copy] autorelease];
}

@end
