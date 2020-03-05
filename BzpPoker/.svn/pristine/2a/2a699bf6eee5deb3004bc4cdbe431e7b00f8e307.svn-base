//
//  ZwMenuView.m
//  AnimationDemo
//
//  Created by DengZw on 16/8/23.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "ZwMenuView.h"

#define kMenuButtonSize 30
#define kMenuButtonSpace 10

@interface ZwMenuView ()
{
    BOOL isMenuOpened;
}

@property (nonatomic, assign) CGPoint point; /**< <#注释文字#> */
@property (nonatomic, strong) NSMutableArray *menuArray; /**< <#注释文字#> */

@property (nullable, nonatomic, weak)id<ZwMenuViewDelegate> delegate;

@end

@implementation ZwMenuView

- (instancetype)initWithPoint:(CGPoint)point delegate:(id<ZwMenuViewDelegate>)delegate
{
    if (self = [super init])
    {
        self.point = point;
        self.delegate = delegate;
        
        isMenuOpened = NO;
        
        [self createUIView];
    }
    
    return self;
}

- (void)createUIView
{
    if (!_menuArray)
    {
        _menuArray = [[NSMutableArray alloc] init];
        [_menuArray addObject:@"ic_menu_exit"];
        [_menuArray addObject:@"ic_menu_setting"];
        [_menuArray addObject:@"ic_menu_question"];
        [_menuArray addObject:@"ic_menu_open"];
    }
    
    CGFloat menuX = self.point.x - kMenuButtonSize * _menuArray.count - kMenuButtonSpace * (_menuArray.count - 1);
    CGFloat menuY = self.point.y;
    
    self.frame = CGRectMake(menuX, menuY, kMenuButtonSize * _menuArray.count + kMenuButtonSpace * (_menuArray.count - 1), kMenuButtonSize);
    
    for (NSInteger x = _menuArray.count; x > 0; x --)
    {
        NSInteger index = _menuArray.count - x;
        CGFloat orignX = (_menuArray.count - 1) * (kMenuButtonSize + kMenuButtonSpace);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:_menuArray[index]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(orignX, 0, kMenuButtonSize, kMenuButtonSize);
        btn.tag = index;
        [btn addTarget:self action:@selector(btnMenuAction:) forControlEvents:UIControlEventTouchUpInside];
        if (x == _menuArray.count - 1)
        {
            btn.transform = CGAffineTransformMakeRotation(0);
        }
        [self addSubview:btn];
    }
}

- (void)btnMenuAction:(UIButton *)btn
{
    if (btn.tag == _menuArray.count - 1)
    {
        // 最后一个按钮，菜单开关
        [self showOrHideMenu];
        isMenuOpened = !isMenuOpened;
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(zwMenuViewSelectedIndex:)])
        {
            [self.delegate zwMenuViewSelectedIndex:btn.tag];
        }
    }
}

- (void)showOrHideMenu
{
    if (isMenuOpened)
    {
        // 如果开了，关
        for (UIButton *btn in self.subviews)
        {
            if ([btn isKindOfClass:[UIButton class]])
            {
                [UIView animateWithDuration:0.35 animations:^{
                    CGFloat orignX = (_menuArray.count - 1) * (kMenuButtonSize + kMenuButtonSpace);
                    btn.frame = CGRectMake(orignX, 0, kMenuButtonSize, kMenuButtonSize);
                    
                    if (btn.tag == _menuArray.count - 1)
                    {
                        [btn setImage:[UIImage imageNamed:@"ic_menu_open"] forState:UIControlStateNormal];
                        btn.transform = CGAffineTransformMakeRotation(0);
                    }
                }];
                
            }
        }
    }
    else
    {
        // 打开
        for (UIButton *btn in self.subviews)
        {
            if ([btn isKindOfClass:[UIButton class]])
            {
                [UIView animateWithDuration:0.35 animations:^{
                    CGFloat orignX = btn.tag * (kMenuButtonSize + kMenuButtonSpace);
                    btn.frame = CGRectMake(orignX, 0, kMenuButtonSize, kMenuButtonSize);
                    
                    if (btn.tag == _menuArray.count - 1)
                    {
                        [btn setImage:[UIImage imageNamed:@"ic_menu_close"] forState:UIControlStateNormal];
                        btn.transform = CGAffineTransformMakeRotation(M_PI);
                    }
                }];
            }
        }
    }
}

@end
