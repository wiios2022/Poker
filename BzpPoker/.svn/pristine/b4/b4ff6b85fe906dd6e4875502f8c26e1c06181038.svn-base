//
//  BaseCardType.h
//  Poker
//
//  Created by DengZw on 16/8/4.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardModel.h"

/**
 *  牌型基类
 */

typedef NS_ENUM(NSInteger, CardType)
{
    CardType_Error = -1,            // 错误牌型
    CardType_A = 0,                 // 单牌
    CardType_AA = 1,                    // 对子
    CardType_ABC = 2,                   // 顺子
    CardType_AAA = 6,                   // 炸弹
    CardType_AABBCC = 10,                // 板子炮（双顺、双龙）
    CardType_AAAA = 14,                  // 豆
    CardType_AAABBBCCC = 18,             // 滚筒
    CardType_AAAABBBBCCCC = 22,          // 滚龙
    CardType_13L = 26                    // 十三烂（天牌）
};

@interface BaseCardType : NSObject

@end
