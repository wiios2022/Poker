//
//  ZwFoldCardsView.m
//  BzpPoker
//
//  Created by DengZw on 16/9/9.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "ZwFoldCardsView.h"

#define kFoldCardsViewSpaceSize 0.2f

@interface ZwFoldCardsView ()

@property (nonatomic, assign) NSInteger count; /**< 牌的张数 */

@end

@implementation ZwFoldCardsView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.count = 0;
    }
    
    return self;
}

- (void)createUIView
{
    // 创建时，先移除旧的视图
    if (self.subviews)
    {
        for (UIView *view in self.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    for(int x = 0; x < _count; x ++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kFoldCardsViewSpaceSize * x, kFoldCardsViewSpaceSize * x, 28, 39)];
        [imgView setImage:[UIImage imageNamed:@"img_game_fold"]];
        [self addSubview:imgView];
    }
}


- (void)setCardsCount:(NSInteger)count
{
    _count += count;
    [self createUIView];
}

@end
