//
// ECGraphItem.h
//
// Create By ECGenerateCode
// Date:2010-05-12 02:27:50
//
//!--
//This is generated by code generater automatic,pls check the type of variables.
//Change them to other suitable type(NSString is by default) if needed.
//--

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ECGraphItem : NSObject {
	NSString	*name;
    NSString *actualName;
	UIColor	*color;
	float			yValue;
    NSInteger actualYValue;
	NSDate		*yDateValue;
	BOOL		isYDate;
	BOOL		isPercentage;
	float			width;
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *actualName;
@property(nonatomic,retain) UIColor *color;
@property(nonatomic,assign) float yValue;
@property(nonatomic, assign) NSInteger actualYValue;
@property(nonatomic,retain) NSDate *yDateValue;
@property(nonatomic,assign) BOOL isYDate;
@property(nonatomic,assign) BOOL isPercentage;
@property(nonatomic,assign) float width;

@end