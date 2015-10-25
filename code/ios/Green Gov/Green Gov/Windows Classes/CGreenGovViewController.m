//
//  CGreenGovViewController.m
//  Green Gov
//
//  Created by Allen Yee on 10/16/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import "CGreenGovViewController.h"
#import "CGreenGovNavigationBar.h"
#import "CGreenGovCO2BarViewController.h"
#import "CGreenGovCountiesLookupOperation.h"
#import "CGreenGovCountyInfoLookupOperation.h"
#import "CGreenGovFleetOperation.h"


@interface CGreenGovViewController () <CGreenGovCountiesLookupOperationDelegate, CGreenGovCountyInfoLookupOperationDelegate, CGreenGovFleetOperationDelegate>
{
    CGreenGovNavigationBar* m_navigationBar;
    UITableView* m_tableView;
    UIPickerView* m_yearView;
    UIButton* m_goButton;
    
    CGreenGovCO2BarViewController* m_co2BarGraphViewController;
    
    NSOperationQueue* m_operationQueue;
    NSMutableArray* m_list;
    NSMutableArray* m_selectedList;
    NSMutableArray* m_yearList;
}


@property (nonatomic, retain) IBOutlet UITableView* m_tableView;
@property (nonatomic, retain) IBOutlet CGreenGovNavigationBar* m_navigationBar;
@property (nonatomic, retain) IBOutlet UIPickerView* m_yearView;
@property (nonatomic, retain) IBOutlet UIButton* m_goButton;

@property (nonatomic, retain) CGreenGovCO2BarViewController* m_co2BarGraphViewController;

@property (nonatomic, retain) NSOperationQueue* m_operationQueue;
@property (nonatomic, retain) NSMutableArray* m_list;
@property (nonatomic, retain) NSMutableArray* m_selectedList;
@property (nonatomic, retain) NSMutableArray* m_yearList;


@end


@implementation CGreenGovViewController


@synthesize m_navigationBar;
@synthesize m_tableView;
@synthesize m_yearView;
@synthesize m_goButton;

@synthesize m_co2BarGraphViewController;

@synthesize m_operationQueue;
@synthesize m_list;
@synthesize m_selectedList;
@synthesize m_yearList;


-(void)refreshXML
{
    NSString* year;
    NSInteger row;
    
    [self.m_selectedList removeAllObjects];
    row = [self.m_yearView selectedRowInComponent:0];
    year = [self.m_yearList objectAtIndex:row];
    [self.m_operationQueue cancelAllOperations];
    CGreenGovFleetOperation* operation = [[[CGreenGovFleetOperation alloc] initWithDelegate:self Year:year] autorelease];
    [self.m_operationQueue addOperation:operation];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.m_selectedList = [[NSMutableArray alloc] init];
    self.m_yearList = [[NSMutableArray alloc] init];
    [self.m_yearList addObject:@"All"];
    [self.m_yearList addObject:@"2011"];
    [self.m_yearList addObject:@"2012"];
    [self.m_yearList addObject:@"2013"];
    [self.m_yearList addObject:@"2014"];
    
    self.m_operationQueue = [[NSOperationQueue alloc] init];
    [self.m_navigationBar showLeftButton:NO];
    [self.m_navigationBar showRightButton:NO];
    self.m_goButton.layer.borderWidth = 1;
    self.m_goButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.m_goButton.layer.cornerRadius = 5;
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [self refreshXML];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma CGreenGovOperationDelegate methods


-(void)greenGovCountiesLookupOperationUpdated:(CGreenGovCountiesLookupOperation*)operation List:(NSMutableArray*)list
{
    self.m_list = list;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.m_tableView reloadData];
    });
}


-(void)greenGovCountyInfoLookupUpdated:(CGreenGovCountyInfoLookupOperation *)operation List:(NSMutableArray *)list
{
    
}


-(void)greenGovFleetDataOperationUpdated:(CGreenGovFleetOperation *)operation List:(NSMutableArray *)list
{
    self.m_list = [[NSMutableArray alloc] initWithArray:list];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.m_tableView reloadData];
    });
}


#pragma mark UITableViewDelegate methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [self.m_list count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    UILabel* lblTemp;
    NSObject* obj;
    CGreenGovCounty* county;
    CGreenGovFleet* fleet;
    NSInteger tag;
    static NSString *CellIdentifier = @"GreenGovCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        tag = tableView.tag+100;
        lblTemp = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 25)];
        lblTemp.tag = tag++;
        [lblTemp setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        lblTemp.backgroundColor = [UIColor clearColor];
        lblTemp.textColor = [UIColor blackColor];
        [cell.contentView addSubview:lblTemp];
        [lblTemp release];
    }
    obj = [self.m_list objectAtIndex:indexPath.row];
    tag = tableView.tag+100;
    lblTemp = (UILabel*)[cell viewWithTag:tag++];
    if ([obj isKindOfClass:[CGreenGovCounty class]])
    {
        county = (CGreenGovCounty*)obj;
        lblTemp.text = county.m_name;
    }
    else if ([obj isKindOfClass:[CGreenGovFleet class]])
    {
        fleet = (CGreenGovFleet*)obj;
        lblTemp.text = fleet.m_name;
    }
    lblTemp.adjustsFontSizeToFitWidth = YES;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGreenGovFleet* fleet;
    
    fleet = [self.m_list objectAtIndex:indexPath.row];
    [self.m_selectedList addObject:fleet];
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGreenGovFleet* fleet;
    
    fleet = [self.m_list objectAtIndex:indexPath.row];
    [self.m_selectedList removeObject:fleet];
}


#pragma mark UIPickerView methods


-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.m_yearList count];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.m_yearList objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self refreshXML];    
}


#pragma mark UIButton methods


-(IBAction)goButtonTouched:(id)sender
{
    NSString* year;
    NSInteger row;
    
    row = [self.m_yearView selectedRowInComponent:0];
    year = [self.m_yearList objectAtIndex:row];
    if (self.m_co2BarGraphViewController==nil)
    {
        self.m_co2BarGraphViewController = [[CGreenGovCO2BarViewController alloc] initWithNibName:@"CGreenGovCO2BarViewController" bundle:nil];
    }
    self.m_co2BarGraphViewController.m_list = self.m_selectedList;
    self.m_co2BarGraphViewController.m_year = year;
    [self presentViewController:self.m_co2BarGraphViewController animated:NO completion:^{}];
}


@end
