//
//  CheckCardType.m
//  Poker
//
//  Created by DengZw on 16/8/4.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "CheckCardType.h"

@implementation CheckCardType

#pragma mark - 牌型判断
#pragma mark -

+ (CardType)gotTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    
    switch (cards.count)
    {
        case 1:
        {
            // 单牌
            type = [self gotDanPaiTypeByCards:cards];
            break;
        }
        case 2:
        {
            // 对子
            type = [self gotDuiZiTypeByCards:cards];
            break;
        }
        case 3:
        {
            // 可能的牌型：炸弹，顺子
            type = [self gotZhaDanTypeByCards:cards];
            if (type == CardType_Error)
            {
                type = [self gotShunZiTypeByCards:cards];
            }
            break;
        }
        case 4:
        {
            // 可能的牌型：豆，顺子
            type = [self gotDouTypeByCards:cards];
            if (type == CardType_Error)
            {
                type = [self gotShunZiTypeByCards:cards];
            }
            break;
        }
        case 6:
        {
            // 可能的牌型：板子，顺子
            type = [self gotBanZiPaoTypeByCards:cards];
            if (type == CardType_Error)
            {
                type = [self gotShunZiTypeByCards:cards];
            }
            break;
        }
        case 8:
        {
            // 可能的牌型：板子，顺子
            type = [self gotBanZiPaoTypeByCards:cards];
            if (type == CardType_Error)
            {
                type = [self gotShunZiTypeByCards:cards];
            }
            break;
        }
        case 9:
        {
            // 可能的牌型：滚筒，板子，顺子
            type = [self gotGunTongTypeByCards:cards];
            if (type == CardType_Error)
            {
                type = [self gotBanZiPaoTypeByCards:cards];
                if (type == CardType_Error)
                {
                    type = [self gotShunZiTypeByCards:cards];
                }
            }
            break;
        }
        case 10:
        {
            // 可能的牌型：板子，顺子
            type = [self gotBanZiPaoTypeByCards:cards];
            if (type == CardType_Error)
            {
                type = [self gotShunZiTypeByCards:cards];
            }
            break;
        }
        case 12:
        {
            // 从大到小判断，可能的牌型：滚龙，滚筒，板子炮，顺
            type = [self gotGunLongTypeByCards:cards];
            if (type == CardType_Error)
            {
                type = [self gotGunTongTypeByCards:cards];
                if (type == CardType_Error)
                {
                    type = [self gotBanZiPaoTypeByCards:cards];
                    if (type == CardType_Error)
                    {
                        type = [self gotShunZiTypeByCards:cards];
                    }
                }
            }
            break;
        }
        case 13:
        {
            // 只能是十三烂
            type = [self gotShiSanLanTypeByCards:cards];
            break;
        }
        default:
        {
            // 其它情况判断是否顺子
            type = [self gotShunZiTypeByCards:cards];
            break;
        }
            
    }
    
    NSLog(@"type:%ld", (long)type);
    
    return type;
}

#pragma mark - 牌型判断 - 单牌
+ (CardType)gotDanPaiTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    
    if (cards.count == 1)
    {
        type = CardType_A;
    }
    else
    {
        type = CardType_Error;
    }
    
    return type;
}

#pragma mark - 牌型判断-对子
+ (CardType)gotDuiZiTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    
    // 记录卡牌的数字
    NSInteger cardNum = 0;
    // 记录卡牌数字相待的次数
    NSInteger count = 0;
    
    if (cards.count == 2)
    {
        for (CardModel *model in cards)
        {
            if (model.num == cardNum)
            {
                count ++;
            }
            else
            {
                cardNum = model.num;
            }
        }
        
        if (count == cards.count - 1)
        {
            type = CardType_AA;
        }
        else
        {
            type = CardType_Error;
        }
    }
    
    return type;
}

#pragma mark - 牌型判断-炸弹
+ (CardType)gotZhaDanTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    
    // 记录卡牌的数字
    NSInteger cardNum = 0;
    // 记录卡牌数字相待的次数
    NSInteger count = 0;
    
    if (cards.count == 3)
    {
        for (CardModel *model in cards)
        {
            if (model.num == cardNum)
            {
                count ++;
            }
            else
            {
                cardNum = model.num;
            }
        }
        
        if (count == cards.count - 1)
        {
            type = CardType_AAA;
        }
        else
        {
            type = CardType_Error;
        }
    }
    
    return type;
}

#pragma mark - 牌型判断-豆-4条
+ (CardType)gotDouTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    
    // 记录卡牌的数字
    NSInteger cardNum = 0;
    // 记录卡牌数字相待的次数
    NSInteger count = 0;
    
    if (cards.count == 4)
    {
        for (CardModel *model in cards)
        {
            if (model.num == cardNum)
            {
                count ++;
            }
            else
            {
                cardNum = model.num;
            }
        }
        
        if (count == cards.count - 1)
        {
            type = CardType_AAAA;
        }
        else
        {
            type = CardType_Error;
        }
    }
    
    return type;
}

#pragma mark - 牌型判断-十三烂或者顺子
+ (CardType)gotShunZiTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    if (cards.count >= 3 && cards.count < 13)
    {
        // 记录卡牌数字不相等的数数字
        NSMutableArray *numArray = [[NSMutableArray alloc] init];
        
        // 记录是否有相同的数字
        BOOL isHasSameNum = NO;
        
        for (CardModel *model in cards)
        {
            NSString *numString = [NSString stringWithFormat:@"%ld", (long)model.num];
            if (![numArray containsObject:numString])
            {
                [numArray addObject:numString];
            }
            else
            {
                isHasSameNum = YES;
                break;
            }
        }
        
        // 如果有重复的，则不是连子
        if (isHasSameNum)
        {
            type = CardType_Error;
        }
        else
        {
            CardModel *lastModel = [cards lastObject];
            if (lastModel.num == 15)
            {
                // 如果没有13张，且其中含有2，则不是顺子
                type = CardType_Error;
            }
            else
            {
                CardModel *firstModel = [cards firstObject];
                CardModel *lastModel = [cards lastObject];
                
                if (lastModel.num - firstModel.num + 1 == cards.count)
                {
                    // 比如4、5、6、7、8, 则判断8-4+1=5
                    type = CardType_ABC;
                }
                else
                {
                    type = CardType_Error;
                }
                
            }
        }
        
    }
    
    return type;
}


#pragma mark - 牌型判断-板子炮（也叫双龙，或双顺）
+ (CardType)gotBanZiPaoTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    if (cards.count == 6 ||
        cards.count == 8 ||
        cards.count == 10 ||
        cards.count == 12)
    {
        CardModel *lastModel = [cards lastObject];
        
        if (lastModel.num == 15)
        {
            type = CardType_Error;
        }
        else
        {
            CardModel *firstModel = [cards firstObject];
            CardModel *lastModel = [cards lastObject];
            
            // 比如334455，最后一个数字减去第一个数字之差，加上1，乘以2，等于总个数
            // 避免出现 344556，这种情况，也是两个顺子，但是起始位置不一致
            if ((lastModel.num - firstModel.num + 1) * 2 == cards.count)
            {
                // 判断拆开后，2个都是顺子
                BOOL isShunZi = YES;
                
                for (int x = 0; x < 2; x ++)
                {
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (int y = 0; y < cards.count / 2; y ++)
                    {
                        NSInteger index = y * 2 + x;
                        CardModel *model = cards[index];
                        [tmpArray addObject:model];
                    }
                    
                    // 如果其中一个不是顺子，则不是板子，判断结束，跳出循环
                    if ([self gotShunZiTypeByCards:tmpArray] == CardType_Error)
                    {
                        isShunZi = NO;
                        break;
                    }
                }
                
                // 三个都是顺子，则为滚筒
                if (isShunZi)
                {
                    type = CardType_AABBCC;
                }
                else
                {
                    type = CardType_Error;
                }
                
            }
            else
            {
                type = CardType_Error;
            }
            
        }
    }
    
    return type;
}

#pragma mark - 牌型判断-滚筒
+ (CardType)gotGunTongTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    if (cards.count == 9 ||
        cards.count == 12)
    {
        CardModel *lastModel = [cards lastObject];
        
        if (lastModel.num == 15)
        {
            type = CardType_Error;
        }
        else
        {
            CardModel *firstModel = [cards firstObject];
            CardModel *lastModel = [cards lastObject];
            
            // 比如333444555，最后一个数字减去第一个数字之差，加上1，乘以3，等于总个数
            // 避免出现 334445556，这种情况，也是两个顺子，但是起始位置不一致
            if ((lastModel.num - firstModel.num + 1) * 3 == cards.count)
            {
                // 判断拆开后，3个都是顺子
                BOOL isShunZi = YES;
                
                for (int x = 0; x < 3; x ++)
                {
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (int y = 0; y < cards.count / 3; y ++)
                    {
                        NSInteger index = y * 3 + x;
                        CardModel *model = cards[index];
                        [tmpArray addObject:model];
                    }
                    
                    // 如果其中一个不是顺子，则不是滚筒，判断结束，跳出循环
                    if ([self gotShunZiTypeByCards:tmpArray] == CardType_Error)
                    {
                        isShunZi = NO;
                        break;
                    }
                }
                
                // 三个都是顺子，则为滚筒
                if (isShunZi)
                {
                    type = CardType_AAABBBCCC;
                }
                else
                {
                    type = CardType_Error;
                }
                
            }
            else
            {
                type = CardType_Error;
            }
            
        }
    }
    
    return type;
}

#pragma mark - 牌型判断-滚龙
+ (CardType)gotGunLongTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    if (cards.count == 12)
    {
        CardModel *lastModel = [cards lastObject];
        
        // 如果有2，则不是
        if (lastModel.num == 15)
        {
            type = CardType_Error;
        }
        else
        {
            CardModel *firstModel = [cards firstObject];
            CardModel *lastModel = [cards lastObject];
            
            // 比如333444555，最后一个数字减去第一个数字之差，加上1，乘以3，等于总个数
            // 避免出现 334445556，这种情况，也是两个顺子，但是起始位置不一致
            if ((lastModel.num - firstModel.num + 1) * 4 == cards.count)
            {
                // 判断拆开后，4个都是顺子
                BOOL isShunZi = YES;
                
                for (int x = 0; x < 4; x ++)
                {
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (int y = 0; y < cards.count / 4; y ++)
                    {
                        NSInteger index = y * 4 + x;
                        CardModel *model = cards[index];
                        [tmpArray addObject:model];
                    }
                    
                    // 如果其中一个不是顺子，则不是滚龙，判断结束，跳出循环
                    if ([self gotShunZiTypeByCards:tmpArray] == CardType_Error)
                    {
                        isShunZi = NO;
                        break;
                    }
                }
                
                // 四个都是顺子，则为滚龙
                if (isShunZi)
                {
                    type = CardType_AAAABBBBCCCC;
                }
                else
                {
                    type = CardType_Error;
                }
                
            }
            else
            {
                type = CardType_Error;
            }
            
        }
    }
    
    return type;
}

#pragma mark - 牌型判断-十三烂
+ (CardType)gotShiSanLanTypeByCards:(NSArray *)cards
{
    CardType type = CardType_Error;
    if (cards.count == 13)
    {
        // 记录卡牌数字不相等的数数字
        NSMutableArray *numArray = [[NSMutableArray alloc] init];
        
        // 记录是否有相同的数字
        BOOL isHasSameNum = NO;
        
        for (CardModel *model in cards)
        {
            NSString *numString = [NSString stringWithFormat:@"%ld", (long)model.num];
            if (![numArray containsObject:numString])
            {
                [numArray addObject:numString];
            }
            else
            {
                isHasSameNum = YES;
                break;
            }
        }
        
        if (isHasSameNum)
        {
            type = CardType_Error;
        }
        else
        {
            type = CardType_13L;
        }
    }
    return type;
}


@end
