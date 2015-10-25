//
//  CGreenGovFleetOperation.m
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import "CGreenGovFleetOperation.h"


@interface CGreenGovFleetOperation() <NSXMLParserDelegate>
{
    id<CGreenGovFleetOperationDelegate> m_delegate;
    NSMutableArray* m_list;
    CGreenGovFleet* m_fleet;
    NSString* m_curElementName;
    NSString* m_year;
}


@property (nonatomic, assign) id<CGreenGovFleetOperationDelegate> m_delegate;
@property (nonatomic, retain) NSMutableArray* m_list;
@property (nonatomic, retain) CGreenGovFleet* m_fleet;
@property (nonatomic, retain) NSString* m_curElementName;
@property (nonatomic, retain) NSString* m_year;


@end


@implementation CGreenGovFleetOperation



@synthesize m_delegate;
@synthesize m_list;
@synthesize m_fleet;
@synthesize m_curElementName;
@synthesize m_year;


-(id)initWithDelegate:(id<CGreenGovFleetOperationDelegate>)delegate Year:(NSString*)year
{
    self = [super init];
    if (self)
    {
        self.m_delegate = delegate;
        self.m_list = [[NSMutableArray alloc] init];
        self.m_fleet = nil;
        self.m_curElementName = nil;
        self.m_year = year;
    }
    return self;
}


-(void)dealloc
{
    [super dealloc];
}


-(void)main
{
    NSAutoreleasePool* pool;
    
    pool = [[NSAutoreleasePool alloc] init];
    if(self.m_delegate)
    {
        [self getXML];
    }
    [pool release];
}


#pragma mark NSXMLParserDelegate private methods


-(void)getXML
{
    NSURL* url;
    NSString* http;
    NSData* data=nil;
    NSXMLParser* xmlParser;
    
    [self.m_list removeAllObjects];
    if ([self.m_year isEqualToString:@"All"]==NO)
    {
        http = @"http://159.203.255.155:8080/GreenWebServices-0.0.1-SNAPSHOT/demo/";
        http = [http stringByAppendingString:self.m_year];
        url = [NSURL URLWithString:http];
        data = [NSData dataWithContentsOfURL:url];
        if (data==nil)
        {
            NSString* path;
            NSString* fileName;
            
            if ([self.m_year isEqualToString:@"All"])
                fileName = @"inter_dept";
            else
                fileName = [NSString stringWithFormat:@"inter_dept_%@", self.m_year];
            path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
            data = [NSData dataWithContentsOfFile:path];
        }
    }
    else
    {
        NSString* path;
        NSString* fileName;
        
        if ([self.m_year isEqualToString:@"All"])
            fileName = @"inter_dept";
        else
            fileName = [NSString stringWithFormat:@"inter_dept_%@", self.m_year];
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
        data = [NSData dataWithContentsOfFile:path];
    }
    xmlParser = [[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser setShouldProcessNamespaces:YES];
    [xmlParser setShouldReportNamespacePrefixes:YES];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    [xmlParser release];
}


#pragma mark NSXMLParserDelegate methods


-(void) parserDidStartDocument:(NSXMLParser*)parser
{
}


-(void) parserDidEndDocument:(NSXMLParser*)parser
{
    [self.m_delegate greenGovFleetDataOperationUpdated:self List:self.m_list];
}


-(void) parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError
{
    [self.m_delegate greenGovFleetDataOperationUpdated:self List:nil];
}


-(void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName attributes:(NSDictionary*)attributeDict
{
    self.m_curElementName = elementName;
    if ([self.m_curElementName isEqualToString:@"department"])
        self.m_fleet = [[CGreenGovFleet alloc] init];
}


-(void)parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName
{
    if ([elementName isEqualToString:@"department"])
    {
        if (self.m_fleet.m_co2!=INFINITY)
            [self.m_list addObject:self.m_fleet];
        self.m_fleet = nil;
    }
    self.m_curElementName = nil;
}


-(void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string
{
    if ([self.m_curElementName isEqualToString:@"name"])
    {
        self.m_fleet.m_name = string;
    }
    else if ([self.m_curElementName isEqualToString:@"Asset_Value"])
    {
        self.m_fleet.m_assetValue = [string doubleValue];
    }
    else if ([self.m_curElementName isEqualToString:@"co2"])
    {
        if ([string isEqualToString:@"Infinity"])
            self.m_fleet.m_co2 = INFINITY;
        else
            self.m_fleet.m_co2 = [string doubleValue];
    }
    else if ([self.m_curElementName isEqualToString:@"Head_Count"])
    {
        self.m_fleet.m_headCount = [string integerValue];
    }
    else if ([self.m_curElementName isEqualToString:@"Dept_Budget"])
    {
        self.m_fleet.m_deptBudget = [string doubleValue];
    }
}


@end
