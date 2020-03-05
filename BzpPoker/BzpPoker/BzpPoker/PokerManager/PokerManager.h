//
//  PokerManager.h
//  Poker
//
//  Created by DengZw on 16/6/30.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardModel.h"
#import "NSMutableArray+Sort.h"

@interface PokerManager : NSObject

+ (instancetype)shareManager;

// 52张牌分配到4个玩家
- (NSMutableArray *)distributeCardsTo4Players;

@end
