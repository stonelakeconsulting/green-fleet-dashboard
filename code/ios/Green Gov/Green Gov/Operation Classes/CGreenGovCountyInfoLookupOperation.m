//
//  CGreenGovCountyInfoLookupOperation.m
//  Green Gov
//
//  Created by Allen Yee on 10/16/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import "CGreenGovCountyInfoLookupOperation.h"


@interface CGreenGovCountyInfoLookupOperation() <NSXMLParserDelegate>
{
    id<CGreenGovCountyInfoLookupOperationDelegate> m_delegate;
    NSString* m_name;
    NSMutableArray* m_list;
    NSString* m_curElementName;
}


@property (nonatomic, assign) id<CGreenGovCountyInfoLookupOperationDelegate> m_delegate;
@property (nonatomic, retain) NSString* m_name;
@property (nonatomic, retain) NSMutableArray* m_list;
@property (nonatomic, retain) NSString* m_curElementName;


@end


@implementation CGreenGovCountyInfoLookupOperation


@synthesize m_delegate;
@synthesize m_name;
@synthesize m_list;
@synthesize m_curElementName;


-(id)initWithDelegate:(id<CGreenGovCountyInfoLookupOperationDelegate>)delegate County:(NSString*)name;
{
    self = [super init];
    if (self)
    {
        self.m_delegate = delegate;
        self.m_name = name;
        self.m_list = [[NSMutableArray alloc] init];
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


#pragma mark CGreenGovCountyInfoLookupOperation private methods


-(void)getXML
{
    NSURL* url;
    NSString* http;
    NSData* data;
    NSXMLParser* xmlParser;
    
    http = [NSString stringWithFormat:@"http://159.203.255.155:8080/GreenWebServices-0.0.1-SNAPSHOT/housing/%@", self.m_name];
    http = [http stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    url = [NSURL URLWithString:http];
    data = [NSData dataWithContentsOfURL:url];
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
    [self.m_delegate greenGovCountyInfoLookupUpdated:self List:self.m_list];
}


-(void) parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError
{
    [self.m_delegate greenGovCountyInfoLookupUpdated:self List:nil];
}


-(void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName attributes:(NSDictionary*)attributeDict
{
    self.m_curElementName = elementName;
}


-(void)parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName
{
    self.m_curElementName = nil;
}


-(void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string
{
    NSLog(@"%@=%@", self.m_curElementName, string);
    if ([self.m_curElementName isEqualToString:@"county"])
    {
        [self.m_list addObject:string];
    }
}


@end
