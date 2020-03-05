//
//  ZwLoadingView.m
//  AnimationDemo
//
//  Created by DengZw on 16/8/22.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "ZwLoadingView.h"

#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)

@interface ZwLoadingView ()
{
    UIImageView *tagImgView;
    UIImageView *loadingImgView;
}

@property (nonatomic, strong) UIViewController *parentVc; /**< <#注释文字#> */

@end

@implementation ZwLoadingView

- (instancetype)initWithViewController:(UIViewController *)parentVc
{
    if (self = [super init])
    {
        self.frame = parentVc.view.bounds;
        [self createUIView];
        
        self.parentVc = parentVc;
    }
    
    return self;
}

- (void)createUIView
{
    loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    loadingImgView.center = self.center;
    loadingImgView.image = [UIImage imageNamed:@"ic_loading_animate"];
    [self addSubview:loadingImgView];
    
    tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 38)];
    tagImgView.center = self.center;
    tagImgView.image = [UIImage imageNamed:@"ic_loading_tag"];
    [self addSubview:tagImgView];
}

- (void)startAnimating
{
    [self.parentVc.view addSubview:self];
    
    CABasicAnimation *zAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    zAnimation.duration = 1.2f;
    zAnimation.fromValue = [NSNumber numberWithFloat:0];
    zAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    zAnimation.repeatCount = HUGE_VALF;
    [loadingImgView.layer addAnimation:zAnimation forKey:@"zTransform"];
    
    CABasicAnimation *yAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    yAnimation.duration = 2.0f;
    yAnimation.fromValue = [NSNumber numberWithFloat:-M_PI];
    yAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    yAnimation.repeatCount = HUGE_VALF;
    [tagImgView.layer addAnimation:yAnimation forKey:@"yTransform"];
    
    [self setNeedsDisplay];
}

- (void)stopAnimating
{
    [loadingImgView.layer removeAllAnimations];
    [tagImgView.layer removeAllAnimations];
    
    if (self && self.superview)
    {
        [self removeFromSuperview];
    }
}

@end
