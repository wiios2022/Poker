//
//  ZwCardView.h
//  Poker
//
//  Created by DengZw on 16/7/22.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardModel.h"

#define kCardViewPreDiscardHeight 15

@class ZwCardView;

@protocol ZwCardViewDelegate <NSObject>

- (void)zwCardView:(ZwCardView *)cardView cardBtnSelected:(BOOL)isSelected;

@end

@interface ZwCardView : UIView

@property (nonatomic, strong) CardModel *cardModel; /**< 牌 */
@property (nonatomic, assign) BOOL isPreDiscard; /**< 判断是否预出牌 */
@property (nonatomic, assign) BOOL isSlideEnded; /**< 滑动结束 */
@property (nonatomic, assign) BOOL isShowTranslucentView; /**< 是否显示蒙版 */
@property (nonatomic, weak) id<ZwCardViewDelegate> delegate; /**< 代理 */

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame cardModel:(CardModel *)model;

- (ZwCardView *)duplicateCardView;

@end
