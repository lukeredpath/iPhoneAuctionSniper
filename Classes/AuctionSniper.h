//
//  AuctionSniper.h
//  AuctionSniper
//
//  Created by Luke Redpath on 28/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuctionEventListener.h"
#import "AuctionSniperListener.h"

@interface AuctionSniper : NSObject <AuctionEventListener> {
  id<AuctionSniperListener> sniperListener;
}
- (id)initWithSniperListener:(id<AuctionSniperListener>)listener;
@end
