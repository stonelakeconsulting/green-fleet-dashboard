//
//  CGreenGovCountyInfoLookupOperation.h
//  Green Gov
//
//  Created by Allen Yee on 10/16/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>



@class CGreenGovCountyInfoLookupOperation;


@protocol CGreenGovCountyInfoLookupOperationDelegate


-(void)greenGovCountyInfoLookupUpdated:(CGreenGovCountyInfoLookupOperation*)operation List:(NSMutableArray*)list;


@end


@interface CGreenGovCountyInfoLookupOperation : NSOperation


-(id)initWithDelegate:(id<CGreenGovCountyInfoLookupOperationDelegate>)delegate County:(NSString*)name;


@end
