//
//  main.m
//  AuctionSniper
//
//  Created by Luke Redpath on 23/06/2010.
//  Copyright LJR Software Limited 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cedar-iPhone/Cedar.h>

int main(int argc, char *argv[]) {
  
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int retVal = runAllSpecs();
  [pool release];
  return retVal;
}
