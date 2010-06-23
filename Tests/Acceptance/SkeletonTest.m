//
//  SkeletonTest.m
//  AuctionSniper
//
//  Created by Luke Redpath on 23/06/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#define HC_SHORTHAND
#import <Cedar-iPhone/SpecHelper.h>
#import <OCHamcrest/OCHamcrest.h>

SPEC_BEGIN(SkeletonTest)

describe(@"Skeleton test", ^{
  
  it(@"should pass", ^{
    assertThat(@"Hello", equalTo(@"Hello"));
  });
  
});

SPEC_END

