//
//  PokerManager.m
//  Poker
//
//  Created by DengZw on 16/6/30.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "PokerManager.h"

NSComparator comparator = ^(CardModel *obj1, CardModel *obj2)
{
    if (obj1.num > obj2.num)
    {
        return (NSComparisonResult)NSOrderedDescending;
    }
    else if (obj1.num < obj2.num)
    {
        return (NSComparisonResult)NSOrderedAscending;
    }
    else
    {
        // 如果大小一样，则判断花色
        return (NSComparisonResult)[obj1.tag compare:obj2.tag];
    }
    
    return (NSComparisonResult)NSOrderedSame;
};

@implementation PokerManager

+ (instancetype)shareManager
{
    static PokerManager *manager = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        manager = [[PokerManager alloc] init];
    });
    
    return manager;
}

// 52张牌分配到4个玩家
- (NSMutableArray *)distributeCardsTo4Players
{
    // 生成不同花色的牌
    NSMutableArray *aCardsArray = [self gotCardsBySuit:@"A"];
    NSMutableArray *bCardsArray = [self gotCardsBySuit:@"B"];
    NSMutableArray *cCardsArray = [self gotCardsBySuit:@"C"];
    NSMutableArray *dCardsArray = [self gotCardsBySuit:@"D"];
    
    // 加到所有牌数组
    NSMutableArray *allCardsArray = [[NSMutableArray alloc] init];
    [allCardsArray addObjectsFromArray:aCardsArray];
    [allCardsArray addObjectsFromArray:bCardsArray];
    [allCardsArray addObjectsFromArray:cCardsArray];
    [allCardsArray addObjectsFromArray:dCardsArray];
    
    // 打乱
    [allCardsArray shuffleArray];
    
    NSMutableArray *aPlayerCardsArray = [[NSMutableArray alloc] init];
    NSMutableArray *bPlayerCardsArray = [[NSMutableArray alloc] init];
    NSMutableArray *cPlayerCardsArray = [[NSMutableArray alloc] init];
    NSMutableArray *dPlayerCardsArray = [[NSMutableArray alloc] init];
    
    for (NSInteger x = 0; x < allCardsArray.count; x++)
    {
        if (x < 13 * 1)
        {
            [aPlayerCardsArray addObject:allCardsArray[x]];
        }
        else if (x < 13 * 2)
        {
            [bPlayerCardsArray addObject:allCardsArray[x]];
        }
        else if (x < 13 * 3)
        {
            [cPlayerCardsArray addObject:allCardsArray[x]];
        }
        else if (x < 13 * 4)
        {
            [dPlayerCardsArray addObject:allCardsArray[x]];
        }
    }
    
    aPlayerCardsArray = [self sortCardNumByArray:aPlayerCardsArray];
    bPlayerCardsArray = [self sortCardNumByArray:bPlayerCardsArray];
    cPlayerCardsArray = [self sortCardNumByArray:cPlayerCardsArray];
    dPlayerCardsArray = [self sortCardNumByArray:dPlayerCardsArray];
    
    
    NSMutableArray *allPlayerCardsArray = [[NSMutableArray alloc] init];
    [allPlayerCardsArray addObject:aPlayerCardsArray];
    [allPlayerCardsArray addObject:bPlayerCardsArray];
    [allPlayerCardsArray addObject:cPlayerCardsArray];
    [allPlayerCardsArray addObject:dPlayerCardsArray];
    return allPlayerCardsArray;
}

// 按花色生成13张牌
- (NSMutableArray *)gotCardsBySuit:(NSString *)suit
{
    NSMutableArray *cardsArray = [[NSMutableArray alloc] init];
    for (NSInteger x = 3; x < 16; x ++)
    {
        CardModel *model = [[CardModel alloc] initWithTag:suit andNum:x];
        [cardsArray addObject:model];
    }
    
    return cardsArray;
}

// 按牌面大小排序
- (NSMutableArray *)sortCardNumByArray:(NSMutableArray *)array
{
    NSArray *tmpArray = [[NSArray alloc] init];
    tmpArray = [array sortedArrayUsingComparator:comparator];
    
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:tmpArray];
    
    return newArray;
}

@end
