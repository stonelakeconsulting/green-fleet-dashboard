//
//  CGreenGovFleetOperation.h
//  Green Gov
//
//  Created by Allen Yee on 10/24/15.
//  Copyright © 2015 Forever Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGreenGovFleet.h"


@class CGreenGovFleetOperation;


@protocol CGreenGovFleetOperationDelegate


-(void)greenGovFleetDataOperationUpdated:(CGreenGovFleetOperation*)operation List:(NSMutableArray*)list;


@end


@interface CGreenGovFleetOperation : NSOperation


-(id)initWithDelegate:(id<CGreenGovFleetOperationDelegate>)delegate Year:(NSString*)year;


@end
