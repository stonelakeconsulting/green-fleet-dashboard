//
//  CGreenGovFleet.h
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGreenGovFleet : NSObject
{
    NSString* m_name;
    double m_assetValue;
    double m_co2;
    NSInteger m_headCount;
    double m_deptBudget;
}


@property (nonatomic, retain) NSString* m_name;
@property double m_assetValue;
@property double m_co2;
@property NSInteger m_headCount;
@property double m_deptBudget;


@end
