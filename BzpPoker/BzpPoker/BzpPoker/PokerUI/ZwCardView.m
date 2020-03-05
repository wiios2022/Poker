//
//  ZwCardView.m
//  Poker
//
//  Created by DengZw on 16/7/22.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "ZwCardView.h"

@interface ZwCardView ()
{
    UIButton *btnCard; // 点击事件
    UIView *translucentView;    // 选中蒙版
}

@property (nonatomic, strong) UIImageView *bgImgView;  /**< 背景图片 */

@end

@implementation ZwCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createUIView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame cardModel:(CardModel *)model
{
    if (self = [super initWithFrame:frame])
    {
        [self createUIView];
        self.cardModel = model;
    }
    
    return self;
}

// Duplicate UIView
- (ZwCardView *)duplicateCardView
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return (ZwCardView *)[NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)setCardModel:(CardModel *)cardModel
{
    _cardModel = cardModel;
    NSString *imgName = [NSString stringWithFormat:@"%@%ld", cardModel.tag, cardModel.num];
//    imgName = @"00";
    self.bgImgView.image = [UIImage imageNamed:imgName];
}

- (void)createUIView
{
    // 85 * 63
    self.bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgImgView.image = [UIImage imageNamed:@"00"];
    [self addSubview:self.bgImgView];
    
    btnCard = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCard.frame = self.bounds;
    [btnCard addTarget:self action:@selector(btnCardClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnCard];
    
    translucentView = [[UIView alloc] initWithFrame:self.bounds];
    translucentView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [self addSubview:translucentView];
    
    self.isSlideEnded = YES;
    self.isShowTranslucentView = NO;
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    self.isPreDiscard = !_isPreDiscard;
}

- (void)btnCardClickedAction:(UIButton *)btn
{
    self.isPreDiscard = !btn.selected;
}

- (void)setIsPreDiscard:(BOOL)isPreDiscard
{
    btnCard.selected = isPreDiscard;
    _isPreDiscard = isPreDiscard;
    [self reSetBtnCardFrame];
}

- (void)setIsShowTranslucentView:(BOOL)isShowTranslucentView
{
    _isShowTranslucentView = isShowTranslucentView;
    translucentView.hidden = !isShowTranslucentView;
}

- (void)reSetBtnCardFrame
{
    CGRect frame = self.frame;
    
    if (btnCard.selected)
    {
        frame.origin.y -= kCardViewPreDiscardHeight;
    }
    else
    {
        frame.origin.y += kCardViewPreDiscardHeight;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
}

- (void)cardBtnSelected
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zwCardView:cardBtnSelected:)])
    {
        [self.delegate zwCardView:self cardBtnSelected:btnCard.selected];
    }
}

@end
