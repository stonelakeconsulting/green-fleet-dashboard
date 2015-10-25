//
// ECGraphLine.h
//
// Create By ECGenerateCode
// Date:2010-05-12 01:58:19
//
//!--
//This is generated by code generater automatic,pls check the type of variables.
//Change them to other suitable type(NSString is by default) if needed.
//--

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ECGraphLine : NSObject {
	NSArray	*points;		//ECGraphPoint Array
	NSString	*name;			//line name
	UIColor	*color;			//line color
	BOOL		isXDate;
	BOOL		isYDate;
}

@property(nonatomic,retain) NSArray *points;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) UIColor *color;
@property(nonatomic,assign)	BOOL isXDate;
@property(nonatomic,assign) BOOL isYDate;

@end