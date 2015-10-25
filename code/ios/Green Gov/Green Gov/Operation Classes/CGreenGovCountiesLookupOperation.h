//
//  CGreenGovCountiesLookupOperation.h
//  Green Gov
//
//  Created by Allen Yee on 10/16/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGreenGovCounty.h"


@class CGreenGovCountiesLookupOperation;


@protocol CGreenGovCountiesLookupOperationDelegate


-(void)greenGovCountiesLookupOperationUpdated:(CGreenGovCountiesLookupOperation*)operation List:(NSMutableArray*)list;


@end


@interface CGreenGovCountiesLookupOperation : NSOperation


-(id)initWithDelegate:(id<CGreenGovCountiesLookupOperationDelegate>)delegate;


@end
