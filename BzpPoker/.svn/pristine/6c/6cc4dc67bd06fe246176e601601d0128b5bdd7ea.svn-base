//
//  GameUserView.m
//  BzpPoker
//
//  Created by DengZw on 16/9/2.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "GameUserView.h"

@implementation GameUserView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithPoint:(CGPoint)point parentVc:(UIViewController *)parentVc
{
    if (self = [super init])
    {
        self.frame = CGRectMake(point.x, point.y, kGameUserViewSizeWidth, kGameUserViewSizeHeight);
        [self createUIView];
    }
    
    return self;
}

- (void)createUIView
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    self.layer.cornerRadius = 2.0f;
    
    UIImageView *userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 1, 40, 40)];
    userImgView.image = [UIImage imageNamed:@"img_game_userhead"];
    [self addSubview:userImgView];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(2, 44, 44, 7)];
    lblName.text = @"拼命鬼丶";
    lblName.textColor = [UIColor yellowColor];
    lblName.font = [UIFont systemFontOfSize:7];
    [self addSubview:lblName];
    
    UIImageView *moneyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 52 + 2.5, 5, 5)];
    moneyImgView.image = [UIImage imageNamed:@"ic_game_userMoney"];
    [self addSubview:moneyImgView];
    
    UILabel *lblMoney = [[UILabel alloc] initWithFrame:CGRectMake(6+2, 52, 44 - 6, 10)];
    lblMoney.text = @"188800";
    lblMoney.textColor = [UIColor yellowColor];
    lblMoney.font = [UIFont systemFontOfSize:7];
    [self addSubview:lblMoney];
}

@end
