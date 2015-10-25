//
//  CGreenGovBarGraphView.m
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import "CGreenGovBarGraphView.h"
#import "ECGraph.h"
#import "CGreenGovFleet.h"


@interface CGreenGovBarGraphView() <ECGraphDelegate>

@end


@implementation CGreenGovBarGraphView


@synthesize m_list;
@synthesize m_title;
@synthesize m_xAxisTitle;
@synthesize m_yAxisTitle;


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawRect:(CGRect)rect
{
    NSMutableArray* list;
    ECGraphItem* item;
    CGreenGovFleet* fleet;
    double max=0;
    NSInteger i;
    
    for (i=0; i<self.m_list.count; i++)
    {
        fleet = [self.m_list objectAtIndex:i];
        if (max<fleet.m_co2)
            max = fleet.m_co2;
    }
    max += (max/4);
    
    // Drawing code
    [ECGraph removeTitles:self];

    CGContextRef _context = UIGraphicsGetCurrentContext();
    ECGraph *graph = [[ECGraph alloc] initWithFrame:CGRectMake(10, -20, self.frame.size.width, self.frame.size.height)
                                        withContext:_context isPortrait:YES];
    list = [[NSMutableArray alloc] init];
    for (i=0; i<self.m_list.count; i++)
    {
        fleet = [self.m_list objectAtIndex:i];
        item = [[ECGraphItem alloc] init];
        item.isPercentage = YES;
        item.yValue = fleet.m_co2/max*100.0;
        item.actualYValue = round(fleet.m_co2);
        item.width = 35;
        item.name = [NSString stringWithFormat:@"%@ %ld", self.m_xAxisTitle, i+1];
        item.actualName = fleet.m_name;
        [list addObject:item];
    }
    [graph setXaxisTitle:self.m_xAxisTitle];
    [graph setYaxisTitle:self.m_yAxisTitle];
    [graph setGraphicTitle:self.m_title];
    [graph setDelegate:self];
    graph._maxY = max;
    [graph setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
    [graph drawHistogramWithItems:list lineWidth:2 color:[UIColor blackColor]];
}


@end
