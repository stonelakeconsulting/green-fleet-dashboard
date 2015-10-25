//
//  CGreenGovNavigationBar.m
//  VoiceMe
//
//  Created by Allen Yee on 6/24/14.
//  Copyright (c) 2014 Forever Bytes. All rights reserved.
//

#import "CGreenGovNavigationBar.h"
//#import "CGreenGovUtil.h"


#define LEFT_BUTTON_TAG           100
#define RIGHT_BUTTON_TAG          101
#define NAVBAR_COLOR              [UIColor colorWithRed:223.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0]


@implementation CGreenGovNavigationBar


@synthesize m_delegate;


#pragma mark CGreenGovNavigationBar public methods


-(void)showLeftButton:(BOOL)show
{
    UIButton* btn;
    
    btn = (UIButton*)[self viewWithTag:LEFT_BUTTON_TAG];
    btn.hidden = !show;
}


-(void)showRightButton:(BOOL)show
{
    UIButton* btn;
    
    btn = (UIButton*)[self viewWithTag:RIGHT_BUTTON_TAG];
    btn.hidden = !show;
}


#pragma mark CGreenGovNavigationBar private methods


-(void)initialize
{
    UILabel* lblTemp;
    UIButton* btnTemp;
    
    lblTemp = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width, self.frame.size.height-20)];
    lblTemp.text = NSLocalizedString(@"Green Fleet Dashboard", @"Green Fleet Dashboard");
    lblTemp.textAlignment = NSTextAlignmentCenter;
    lblTemp.font = [UIFont fontWithName:@"Cochin-BoldItalic" size:20.0];
    [self addSubview:lblTemp];
    
    btnTemp = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTemp.frame = CGRectMake(10, 20, 44, 44);
    [btnTemp setImage:[UIImage imageNamed:@"NavBar Left Arrow"] forState:UIControlStateNormal];
    btnTemp.tag = LEFT_BUTTON_TAG;
    [btnTemp addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnTemp];

    btnTemp = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTemp.frame = CGRectMake(self.frame.size.width-10, 20, 44, 44);
    //[btnTemp setTitle:NSLocalizedString(@"C", @"C") forState:UIControlStateNormal];
    //[btnTemp setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    //[btnTemp setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    //[btnTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnTemp.titleLabel.font = [UIFont systemFontOfSize:44];
    btnTemp.tag = RIGHT_BUTTON_TAG;
    [btnTemp addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnTemp addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:btnTemp];
    
    self.backgroundColor = NAVBAR_COLOR;
    //[btnTemp release];
}



#pragma mark CGreenGovNavigationBar lifecycle


-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Initialization code
        [self initialize];
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self initialize];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark CGreenGovNavigationBar UIButton methods


-(void)leftButtonClicked:(id)sender
{
    if (self.m_delegate!=nil)
    {
        if ([self.m_delegate respondsToSelector:@selector(greenGovNavigationBarLeftButtonTouched:)])
            [self.m_delegate greenGovNavigationBarLeftButtonTouched:self];
    }
}


-(void)rightButtonClicked:(id)sender
{
    if (self.m_delegate!=nil)
    {
        if ([self.m_delegate respondsToSelector:@selector(greenGovNavigationBarRightButtonTouched:)])
            [self.m_delegate greenGovNavigationBarRightButtonTouched:self];
    }
}


@end
