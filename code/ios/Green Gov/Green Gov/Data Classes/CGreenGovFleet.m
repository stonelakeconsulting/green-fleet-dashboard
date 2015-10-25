//
//  CGreenGovFleet.m
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import "CGreenGovFleet.h"

@implementation CGreenGovFleet


@synthesize m_name;
@synthesize m_assetValue;
@synthesize m_co2;
@synthesize m_headCount;
@synthesize m_deptBudget;


-(id)init
{
    self = [super init];
    if (self!=nil)
    {
        self.m_name = nil;
        self.m_assetValue = 0.0;
        self.m_co2 = 0.0;
        self.m_headCount = 0;
        self.m_deptBudget = 0;
    }
    return self;
}


-(void)dealloc
{
    [super dealloc];
}


@end
