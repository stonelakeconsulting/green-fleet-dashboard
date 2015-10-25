//
//  CGreenGovCountiesLookupOperation.m
//  Green Gov
//
//  Created by Allen Yee on 10/16/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import "CGreenGovCountiesLookupOperation.h"


@interface CGreenGovCountiesLookupOperation() <NSXMLParserDelegate>
{
    id<CGreenGovCountiesLookupOperationDelegate> m_delegate;
    NSMutableArray* m_list;
    NSString* m_curElementName;
}


@property (nonatomic, assign) id<CGreenGovCountiesLookupOperationDelegate> m_delegate;
@property (nonatomic, retain) NSMutableArray* m_list;
@property (nonatomic, retain) NSString* m_curElementName;


@end


@implementation CGreenGovCountiesLookupOperation


@synthesize m_delegate;
@synthesize m_list;
@synthesize m_curElementName;


-(id)initWithDelegate:(id<CGreenGovCountiesLookupOperationDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.m_delegate = delegate;
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


#pragma mark CGreenGovCountiesLookupOperation private methods


-(void)getXML
{
    NSURL* url;
    NSString* http;
    NSData* data;
    NSXMLParser* xmlParser;

    http = @"http://159.203.255.155:8080/GreenWebServices-0.0.1-SNAPSHOT/lookup/counties";
    //http = "http://159.203.255.155:8080/GreenWebServices-0.0.1-SNAPSHOT/housing/Alameda";
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
    [self.m_delegate greenGovCountiesLookupOperationUpdated:self List:self.m_list];
}


-(void) parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError
{
    [self.m_delegate greenGovCountiesLookupOperationUpdated:self List:nil];
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
    if ([self.m_curElementName isEqualToString:@"county"])
    {
        CGreenGovCounty* county;
        
        county = [[CGreenGovCounty alloc] init];
        county.m_name = string;
        [self.m_list addObject:county];
    }
}


@end
