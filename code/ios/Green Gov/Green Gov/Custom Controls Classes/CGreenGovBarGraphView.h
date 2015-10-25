//
//  CGreenGovBarGraphView.h
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGreenGovBarGraphView : UIView
{
    NSMutableArray* m_list;
    NSString* m_title;
    NSString* m_xAxisTitle;
    NSString* m_yAxisTitle;
}


@property (nonatomic, assign) NSMutableArray* m_list;
@property (nonatomic, retain) NSString* m_title;
@property (nonatomic, retain) NSString* m_xAxisTitle;
@property (nonatomic, retain) NSString* m_yAxisTitle;


@end
