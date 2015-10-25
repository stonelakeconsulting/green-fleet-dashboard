//
//  CGreenGovNavigationBar.h
//  VoiceMe
//
//  Created by Allen Yee on 6/24/14.
//  Copyright (c) 2014 Forever Bytes. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CGreenGovNavigationBar;


@protocol CGreenGovNavigationBarDelegate<NSObject>


@optional
-(void)greenGovNavigationBarLeftButtonTouched:(CGreenGovNavigationBar*)nb;
-(void)greenGovNavigationBarRightButtonTouched:(CGreenGovNavigationBar*)nb;


@end



@interface CGreenGovNavigationBar : UIView
{
    id<CGreenGovNavigationBarDelegate> m_delegate;
}


@property (nonatomic, assign) id<CGreenGovNavigationBarDelegate> m_delegate;


-(void)showLeftButton:(BOOL)show;
-(void)showRightButton:(BOOL)show;


@end
