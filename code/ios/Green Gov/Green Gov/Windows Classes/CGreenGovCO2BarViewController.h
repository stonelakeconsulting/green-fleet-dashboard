//
//  CGreenGovCO2BarViewController.h
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGreenGovCO2BarViewController : UIViewController
{
    NSMutableArray* m_list;
    NSString* m_year;
}


@property (nonatomic, assign) NSMutableArray* m_list;
@property (nonatomic, retain) NSString* m_year;


@end
