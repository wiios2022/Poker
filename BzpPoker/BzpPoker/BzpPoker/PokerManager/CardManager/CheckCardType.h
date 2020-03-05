//
//  CheckCardType.h
//  Poker
//
//  Created by DengZw on 16/8/4.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "BaseCardType.h"

/**
 *  判断牌型
 */

@interface CheckCardType : BaseCardType

/**
 *  返回牌型
 *
 *  @param cards 已经按花色及数字排好序的CardModel数组
 *
 *  @return 牌型
 */
+ (CardType)gotTypeByCards:(NSArray *)cards;

@end
