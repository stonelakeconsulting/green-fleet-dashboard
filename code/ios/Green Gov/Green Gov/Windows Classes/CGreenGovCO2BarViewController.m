//
//  CGreenGovCO2BarViewController.m
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import "CGreenGovCO2BarViewController.h"
#import "CGreenGovNavigationBar.h"
#import "CGreenGovBarGraphView.h"


@interface CGreenGovCO2BarViewController () <CGreenGovNavigationBarDelegate>
{
    CGreenGovNavigationBar* m_navigationBar;
    CGreenGovBarGraphView* m_barGraphView;
}


@property (nonatomic, retain) IBOutlet CGreenGovNavigationBar* m_navigationBar;
@property (nonatomic, retain) IBOutlet CGreenGovBarGraphView* m_barGraphView;


@end


@implementation CGreenGovCO2BarViewController


@synthesize m_list;
@synthesize m_year;

@synthesize m_navigationBar;
@synthesize m_barGraphView;


-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.m_navigationBar showLeftButton:YES];
    [self.m_navigationBar showRightButton:NO];
    self.m_navigationBar.m_delegate = self;
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    self.m_barGraphView.m_list = self.m_list;
    self.m_barGraphView.m_title = [NSString stringWithFormat:@"CO2 Emissions by Department, %@", self.m_year];
    self.m_barGraphView.m_xAxisTitle = @"Dept";
    self.m_barGraphView.m_yAxisTitle = @"CO2";
    [self.m_barGraphView setNeedsDisplay];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark CGreenGovNavigationBarDelegate methods


-(void)greenGovNavigationBarLeftButtonTouched:(CGreenGovNavigationBar*)nb
{
    [self dismissViewControllerAnimated:NO completion:^{}];
}


-(void)greenGovNavigationBarRightButtonTouched:(CGreenGovNavigationBar*)nb
{
}


@end
