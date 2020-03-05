//
//  BigCardType.m
//  Poker
//
//  Created by DengZw on 16/8/4.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "BigCardType.h"

#import "CheckCardType.h"

@interface BigCardType ()

@property (nonatomic, strong) NSMutableArray *oneNumArray; /**< 用来存储一个点数相同的牌 */
@property (nonatomic, strong) NSMutableArray *twoNumArray; /**< 用来存储两个点数相同的牌 */
@property (nonatomic, strong) NSMutableArray *threeNumArray; /**< 用来存储三个点数相同的牌 */
@property (nonatomic, strong) NSMutableArray *fourNumArray; /**< 用来存储四个点数相同的牌 */

@property (nonatomic, strong) NSMutableArray *allSingleNumArray; /**< 用来存储所有不重复的点数 */

@end

@implementation BigCardType

+ (instancetype)sharedBigger
{
    static BigCardType *_shareBigger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareBigger = [[BigCardType alloc] init];

        _shareBigger.oneNumArray = [[NSMutableArray alloc] init];
        _shareBigger.twoNumArray = [[NSMutableArray alloc] init];
        _shareBigger.threeNumArray = [[NSMutableArray alloc] init];
        _shareBigger.fourNumArray = [[NSMutableArray alloc] init];
        
        _shareBigger.allSingleNumArray = [[NSMutableArray alloc] init];

    });
    
    return _shareBigger;
}

- (void)removeNumArrayAllObject
{
    [self.oneNumArray removeAllObjects];
    [self.twoNumArray removeAllObjects];
    [self.threeNumArray removeAllObjects];
    [self.fourNumArray removeAllObjects];
    [self.allSingleNumArray removeAllObjects];
}

- (void)checkNumIsExistedByModel:(CardModel *)model
{
    NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
    if ([self.threeNumArray containsObject:num])
    {
        [self.threeNumArray removeObject:num];
        [self.fourNumArray addObject:num];
    }
    else if ([self.twoNumArray containsObject:num])
    {
        [self.twoNumArray removeObject:num];
        [self.threeNumArray addObject:num];
    }
    else if ([self.oneNumArray containsObject:num])
    {
        [self.oneNumArray removeObject:num];
        [self.twoNumArray addObject:num];
    }
    else
    {
        [self.oneNumArray addObject:num];
    }
    
    if (![self.allSingleNumArray containsObject:num])
    {
        [self.allSingleNumArray addObject:num];
    }
    
}

#pragma mark - 查找大牌型
#pragma mark -

- (NSMutableArray *)gotBigTypeCardsByHandsCards:(NSArray *)handsCards
                                     otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    CardType otherType = [CheckCardType gotTypeByCards:otherCards];
    
    // 把abcd数组中的num移除
    [self removeNumArrayAllObject];
    
    for (CardModel *model in handsCards)
    {
        [self checkNumIsExistedByModel:model];
    }
    
    switch (otherType)
    {
        case CardType_A:
        {
            // 单牌
            bigTypeCards = [self gotBiggerDanPaiByHandsCards:handsCards otherCards:otherCards];
            break;
        }
        case CardType_AA:
        {
            // 对子
            bigTypeCards = [self gotBiggerDuiZiByHandsCards:handsCards otherCards:otherCards];
            break;
        }
        case CardType_ABC:
        {
            // 顺子
            bigTypeCards = [self gotBiggerShunZiByHandsCards:handsCards otherCards:otherCards];
            break;
        }
        case CardType_AAA:
        {
            // 炸弹
            bigTypeCards = [self gotBiggerZhaDanByHandsCards:handsCards otherCards:otherCards];
            break;
        }
        case CardType_AABBCC:
        {
            // 板子炮
            bigTypeCards = [self gotBiggerBzpByHandsCards:handsCards otherCards:otherCards];
            break;
        }
        case CardType_AAAA:
        {
            // 豆
            bigTypeCards = [self gotBiggerDouByHandsCards:handsCards otherCards:otherCards];
            break;
        }
        case CardType_AAABBBCCC:
        {
            // 滚筒
            break;
        }
        case CardType_AAAABBBBCCCC:
        {
            // 滚龙
            break;
        }
        case CardType_13L:
        {
            // 十三烂
            [bigTypeCards removeAllObjects];
            break;
        }
        default:
            break;
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerDanPaiByHandsCards:(NSArray *)handsCards
                                     otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    
    CardModel *otherFirstCardModel = otherCards[0];
    NSInteger otherFirstCardNum = otherFirstCardModel.num;
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if (model.num <= otherFirstCardNum)
        {
            // 如果点数小于other点数
            if ([self.oneNumArray containsObject:num])
            {
                // 单牌
                [bigTypeCards removeObject:model];
            }
            else if ([self.twoNumArray containsObject:num])
            {
                if (![self checkIsBzpModel:model inHandsCards:handsCards])
                {
                    [bigTypeCards removeObject:model];
                }
            }
        }
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerDuiZiByHandsCards:(NSArray *)handsCards
                                    otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    
    CardModel *otherFirstCardModel = otherCards[0];
    NSInteger otherFirstCardNum = otherFirstCardModel.num;
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if ([self.oneNumArray containsObject:num])
        {
            // 单牌
            [bigTypeCards removeObject:model];
        }
        else if ([self.twoNumArray containsObject:num])
        {
            // 对子
            if (model.num <= otherFirstCardNum)
            {
                // 点数小于other
                if (![self checkIsBzpModel:model inHandsCards:handsCards])
                {
                    // 不是板子炮
                    [bigTypeCards removeObject:model];
                }
            }
        }
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerShunZiByHandsCards:(NSArray *)handsCards
                                    otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    
    CardModel *otherFirstCardModel = otherCards[0];
    NSInteger otherFirstCardNum = otherFirstCardModel.num;
    
    NSMutableArray *allArray = [self gotAllBiggerShunZiByNum:otherFirstCardNum + 1
                                                  otherCards:otherCards];
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if ([self.oneNumArray containsObject:num])
        {
            // 单牌
            if (model.num <= otherFirstCardNum)
            {
                [bigTypeCards removeObject:model];
            }
            else
            {
                // 判断是否顺子且数量大于other
                if (![self checkIsShunZiModel:model inAllBigShunZiArray:allArray])
                {
                    [bigTypeCards removeObject:model];
                }
            }
        }
        else if ([self.twoNumArray containsObject:num])
        {
            // 对子
            if (model.num <= otherFirstCardNum)
            {
                // 点数小于other
                if (![self checkIsBzpModel:model inHandsCards:handsCards])
                {
                    // 不是板子炮
                    [bigTypeCards removeObject:model];
                }
            }
            else
            {
                // 判断是否顺子且数量大于other
                if (![self checkIsShunZiModel:model inAllBigShunZiArray:allArray])
                {
                    [bigTypeCards removeObject:model];
                }
            }
        }
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerZhaDanByHandsCards:(NSArray *)handsCards
                                    otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    
    CardModel *otherFirstCardModel = otherCards[0];
    NSInteger otherFirstCardNum = otherFirstCardModel.num;
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if ([self.oneNumArray containsObject:num])
        {
            // 单牌
            [bigTypeCards removeObject:model];
        }
        else if ([self.twoNumArray containsObject:num])
        {
            // 对子
            if (![self checkIsBzpModel:model inHandsCards:handsCards])
            {
                // 不是板子炮
                [bigTypeCards removeObject:model];
            }
        }
        else if ([self.threeNumArray containsObject:num])
        {
            // 如果是炸弹
            // 判断是否滚筒，不是则remove
            if (model.num <= otherFirstCardNum)
            {
                // 点数小于other
                if (![self checkIsGunTongModel:model inHandsCards:handsCards])
                {
                    // 不是滚筒
                    [bigTypeCards removeObject:model];
                }
            }
            
        }
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerBzpByHandsCards:(NSArray *)handsCards
                                     otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];

    NSMutableArray *allArray = [self gotAllBiggerBzpByOtherCards:otherCards];
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if ([self.oneNumArray containsObject:num])
        {
            // 单牌
            [bigTypeCards removeObject:model];
        }
        else if ([self.twoNumArray containsObject:num])
        {
            // 对子
            if (![self checkIsBzpModel:model inHandsCards:handsCards])
            {
                // 不是板子炮
                [bigTypeCards removeObject:model];
            }
            else
            {
                // 是板子炮，则比较大小，小的remove
                if (![self checkIsBzpModel:model inAllBigBzpArray:allArray])
                {
                    [bigTypeCards removeObject:model];
                }
            }
        }
        else if ([self.threeNumArray containsObject:num])
        {
            // 如果是炸弹
            // 判断是否滚筒或者大过的板子炮，不是则remove
            if (![self checkIsBzpModel:model inAllBigBzpArray:allArray] ||
                ![self checkIsGunTongModel:model inHandsCards:handsCards])
            {
                // 不是滚筒，也不是板子炮
                [bigTypeCards removeObject:model];
            }
            
        }
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerDouByHandsCards:(NSArray *)handsCards
                                  otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    
    CardModel *otherFirstCardModel = otherCards[0];
    NSInteger otherFirstCardNum = otherFirstCardModel.num;
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if ([self.oneNumArray containsObject:num])
        {
            // 单牌
            [bigTypeCards removeObject:model];
        }
        else if ([self.twoNumArray containsObject:num])
        {
            // 对子
            [bigTypeCards removeObject:model];
        }
        else if ([self.threeNumArray containsObject:num])
        {
            // 如果是炸弹
            // 判断是否滚筒, 不是则remove
            if (![self checkIsGunTongModel:model inHandsCards:handsCards])
            {
                // 不是滚筒，也不是板子炮
                [bigTypeCards removeObject:model];
            }
            
        }
        else
        {
            // 如果是豆
            if (model.num <= otherFirstCardNum)
            {
                // 判断是不是滚龙，如果不是，remove
                if (![self checkIsGunLongModel:model inHandsCards:handsCards])
                {
                    [bigTypeCards removeObject:model];
                }
            }
        }
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerGunTongByHandsCards:(NSArray *)handsCards
                                  otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    
    NSMutableArray *allBiggerGtArray = [self gotAllBiggerGunTongByOtherCards:otherCards];
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if ([self.oneNumArray containsObject:num])
        {
            // 单牌
            [bigTypeCards removeObject:model];
        }
        else if ([self.twoNumArray containsObject:num])
        {
            // 对子
            [bigTypeCards removeObject:model];
        }
        else if ([self.threeNumArray containsObject:num])
        {
            // 如果是炸弹
            // 判断是否滚筒, 不是则remove
            if (![self checkIsGunTongModel:model inHandsCards:handsCards])
            {
                // 如果不是滚筒，remove
                [bigTypeCards removeObject:model];
            }
            else
            {
                // 是滚筒，则比较大小，小的remove
                if (![self checkIsGtModel:model inAllBigBzpArray:allBiggerGtArray])
                {
                    [bigTypeCards removeObject:model];
                }
            }
        }
        else
        {
            // 如果是豆
            // 判断是不是滚龙，如果不是，remove
            if (![self checkIsGunLongModel:model inHandsCards:handsCards])
            {
                [bigTypeCards removeObject:model];
            }
        }
    }
    
    return bigTypeCards;
}

- (NSMutableArray *)gotBiggerGunLongByHandsCards:(NSArray *)handsCards
                                      otherCards:(NSArray *)otherCards
{
    NSMutableArray *bigTypeCards = [[NSMutableArray alloc] initWithArray:handsCards];
    
    CardModel *otherFirstCardModel = otherCards[0];
    NSInteger otherFirstCardNum = otherFirstCardModel.num;
    
    for (CardModel *model in handsCards)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        
        if ([self.oneNumArray containsObject:num])
        {
            // 单牌
            [bigTypeCards removeObject:model];
        }
        else if ([self.twoNumArray containsObject:num])
        {
            // 对子
            [bigTypeCards removeObject:model];
        }
        else if ([self.threeNumArray containsObject:num])
        {
            // 如果是炸弹
            [bigTypeCards removeObject:model];
        }
        else
        {
            // 如果是豆
            // 判断是不是滚龙，如果不是，remove
            if (![self checkIsGunLongModel:model inHandsCards:handsCards])
            {
                [bigTypeCards removeObject:model];
            }
            else
            {
                // 如果是滚龙，则判断点数
                if (model.num <= otherFirstCardNum)
                {
                    [bigTypeCards removeObject:model];
                }
            }
        }
    }
    
    return bigTypeCards;
}


// 获取到手牌中大过other的全部顺子
- (NSMutableArray *)gotAllBiggerShunZiByNum:(NSInteger)num otherCards:(NSArray *)otherCards
{
    NSMutableArray *allBigShunZiArray = [[NSMutableArray alloc] init];
    
    NSInteger tmpNum = num - 1;
    NSMutableArray *tmpSzArray = [[NSMutableArray alloc] init];
    
    NSNumber *firstNum = [[NSNumber alloc] initWithInteger:num];
    NSInteger index = [self.allSingleNumArray indexOfObject:firstNum];
    
    for (NSInteger x = index; x < self.allSingleNumArray.count; x ++)
    {
        NSInteger xNum = [[self.allSingleNumArray objectAtIndex:x] integerValue];
        if ((tmpNum == xNum - 1) && xNum < 15)
        {
            [tmpSzArray addObject:[[NSNumber alloc] initWithInteger:xNum]];
        }
        else
        {
            if (tmpSzArray.count >= otherCards.count)
            {
                [allBigShunZiArray addObject:tmpSzArray];
                tmpSzArray = [[NSMutableArray alloc] init];
                tmpNum = xNum - 1;
            }
        }
        
        // 如果刚好结束
        if (x == self.allSingleNumArray.count - 1)
        {
            if (tmpSzArray.count >= otherCards.count/2)
            {
                [allBigShunZiArray addObject:tmpSzArray];
            }
        }
        
        tmpNum = xNum;
    }
    
    return allBigShunZiArray;
}

// 获取到手牌中大过other的全部板子炮
- (NSMutableArray *)gotAllBiggerBzpByOtherCards:(NSArray *)otherCards
{
    NSMutableArray *allBigBzpArray = [[NSMutableArray alloc] init];
    
    NSInteger tmpNum = 3;
    NSMutableArray *tmpBzpArray = [[NSMutableArray alloc] init];
    
    CardModel *otherModel = otherCards[0];
    NSInteger firstNum = otherModel.num;
    
    for (NSInteger x = 0; x < self.allSingleNumArray.count; x ++)
    {
        NSInteger xNum = [[self.allSingleNumArray objectAtIndex:x] integerValue];
        if ((tmpNum == xNum - 1) && [self checkBcdArrayContainsNum:[NSNumber numberWithInteger:xNum]] && xNum < 15)
        {
            [tmpBzpArray addObject:[[NSNumber alloc] initWithInteger:xNum]];
        }
        else
        {
            if (tmpBzpArray.count >= otherCards.count/2)
            {
                if (tmpBzpArray.count > otherCards.count/2)
                {
                    // 板子炮的长度大于other
                    [allBigBzpArray addObject:tmpBzpArray];
                }
                else if ([tmpBzpArray[0] integerValue] > firstNum)
                {
                    // 板子炮的长度等于other，且第一个num大于other
                    [allBigBzpArray addObject:tmpBzpArray];
                }
                
                tmpBzpArray = [[NSMutableArray alloc] init];
                tmpNum = xNum - 1;
            }
            else
            {
                tmpBzpArray = [[NSMutableArray alloc] init];
            }
        }
        
        // 如果刚好结束
        if (x == self.allSingleNumArray.count - 1)
        {
            if (tmpBzpArray.count >= otherCards.count/2)
            {
                if (tmpBzpArray.count > otherCards.count/2)
                {
                    [allBigBzpArray addObject:tmpBzpArray];
                }
                else if ([tmpBzpArray[0] integerValue] > firstNum)
                {
                    [allBigBzpArray addObject:tmpBzpArray];
                }
            }
        }
        
        tmpNum = xNum;
    }
    
    return allBigBzpArray;
}

// 获取到手牌中大过other的全部板子炮
- (NSMutableArray *)gotAllBiggerGunTongByOtherCards:(NSArray *)otherCards
{
    NSMutableArray *allBigGtArray = [[NSMutableArray alloc] init];
    
    NSInteger tmpNum = 3;
    NSMutableArray *tmpGtArray = [[NSMutableArray alloc] init];
    
    CardModel *otherModel = otherCards[0];
    NSInteger firstNum = otherModel.num;
    
    for (NSInteger x = 0; x < self.allSingleNumArray.count; x ++)
    {
        NSInteger xNum = [[self.allSingleNumArray objectAtIndex:x] integerValue];
        if ((tmpNum == xNum - 1) && [self checkCdArrayContainsNum:[NSNumber numberWithInteger:xNum]] && xNum < 15)
        {
            [tmpGtArray addObject:[[NSNumber alloc] initWithInteger:xNum]];
        }
        else
        {
            if (tmpGtArray.count >= otherCards.count/3)
            {
                if (tmpGtArray.count > otherCards.count/3)
                {
                    // 板子炮的长度大于other
                    [allBigGtArray addObject:tmpGtArray];
                }
                else if ([tmpGtArray[0] integerValue] > firstNum)
                {
                    // 板子炮的长度等于other，且第一个num大于other
                    [allBigGtArray addObject:tmpGtArray];
                }
                
                tmpGtArray = [[NSMutableArray alloc] init];
                tmpNum = xNum - 1;
            }
            else
            {
                tmpGtArray = [[NSMutableArray alloc] init];
            }
        }
        
        // 如果刚好结束
        if (x == self.allSingleNumArray.count - 1)
        {
            if (tmpGtArray.count >= otherCards.count/3)
            {
                if (tmpGtArray.count > otherCards.count/3)
                {
                    [allBigGtArray addObject:tmpGtArray];
                }
                else if ([tmpGtArray[0] integerValue] > firstNum)
                {
                    [allBigGtArray addObject:tmpGtArray];
                }
            }
        }
        
        tmpNum = xNum;
    }
    
    return allBigGtArray;
}

- (BOOL)checkIsShunZiModel:(CardModel *)model inAllBigShunZiArray:(NSMutableArray *)allArray
{
    BOOL isShunZiModel = NO;
    
    for (NSArray *array in allArray)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        if ([array containsObject:num])
        {
            isShunZiModel = YES;
            break;
        }
    }
    return isShunZiModel;
}

- (BOOL)checkIsBzpModel:(CardModel *)model inAllBigBzpArray:(NSMutableArray *)allArray
{
    BOOL isBzpModel = NO;
    
    for (NSArray *array in allArray)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        if ([array containsObject:num])
        {
            isBzpModel = YES;
            break;
        }
    }
    return isBzpModel;
}

- (BOOL)checkIsGtModel:(CardModel *)model inAllBigBzpArray:(NSMutableArray *)allArray
{
    BOOL isGtModel = NO;
    
    for (NSArray *array in allArray)
    {
        NSNumber *num = [[NSNumber alloc] initWithInteger:model.num];
        if ([array containsObject:num])
        {
            isGtModel = YES;
            break;
        }
    }
    return isGtModel;
}

// 判断model能否与手牌中的其他牌组成板子炮
- (BOOL)checkIsBzpModel:(CardModel *)model inHandsCards:(NSArray *)handsCards
{
    BOOL isBzpModel = NO;
    
    if (handsCards.count < 6)
    {
        // 板子炮的张数不够
        isBzpModel = NO;
    }
    else
    {
        // 板子炮的张数够了，接下来判断是不是板子炮
        NSNumber *numPre1 = [[NSNumber alloc] initWithInteger:model.num - 1];
        NSNumber *numPre2 = [[NSNumber alloc] initWithInteger:model.num - 2];
        NSNumber *numNext1 = [[NSNumber alloc] initWithInteger:model.num + 1];
        NSNumber *numNext2 = [[NSNumber alloc] initWithInteger:model.num + 2];
        
        if ([self checkBcdArrayContainsNum:numPre1] && [self checkBcdArrayContainsNum:numPre2] && model.num - 2 >= 3)
        {
            // 第一种情况
            // numPre2\numPre2\numPre1\numPre1\num\num
            isBzpModel = YES;
        }
        else if ([self checkBcdArrayContainsNum:numPre1] && [self checkBcdArrayContainsNum:numNext1] && model.num - 1 >= 3 && model.num + 1 < 15)
        {
            // 第二种情况
            // numPre1\numPre1\num\num\numNext1\numNext1
            isBzpModel = YES;
        }
        else if ([self checkBcdArrayContainsNum:numNext2] && [self checkBcdArrayContainsNum:numNext1] && model.num + 2 < 15)
        {
            // 第三种情况
            // num\num\numNext1\numNext1\numNext2\numNext2
            isBzpModel = YES;
        }
        else
        {
            isBzpModel = NO;
        }
    }
    
    return isBzpModel;
}

// 判断model能否与手牌中的其他牌组成滚筒
- (BOOL)checkIsGunTongModel:(CardModel *)model inHandsCards:(NSArray *)handsCards
{
    BOOL isGtModel = NO;
    
    if (handsCards.count < 9)
    {
        // 滚筒的张数不够
        isGtModel = NO;
    }
    else
    {
        // 滚筒的张数够了，接下来判断是不是滚筒
        NSNumber *numPre1 = [[NSNumber alloc] initWithInteger:model.num - 1];
        NSNumber *numPre2 = [[NSNumber alloc] initWithInteger:model.num - 2];
        NSNumber *numNext1 = [[NSNumber alloc] initWithInteger:model.num + 1];
        NSNumber *numNext2 = [[NSNumber alloc] initWithInteger:model.num + 2];
        
        if ([self checkCdArrayContainsNum:numPre1] && [self checkCdArrayContainsNum:numPre2] && model.num - 2 >= 3)
        {
            // 第一种情况
            // numPre2\numPre2\numPre2\numPre1numPre1\numPre1\num\num\num
            isGtModel = YES;
        }
        else if ([self checkCdArrayContainsNum:numPre1] && [self checkCdArrayContainsNum:numNext1] && model.num - 1 >= 3 && model.num + 1 < 15)
        {
            // 第二种情况
            // numPre1\numPre1\numPre1\num\num\num\numNext1\numNext1\numNext1
            isGtModel = YES;
        }
        else if ([self checkCdArrayContainsNum:numNext2] && [self checkCdArrayContainsNum:numNext1] && model.num + 2 < 15)
        {
            // 第三种情况
            // num\num\num\numNext1\numNext1\numNext1\numNext2\numNext2\numNext2
            isGtModel = YES;
        }
        else
        {
            isGtModel = NO;
        }
    }
    
    return isGtModel;
}

// 判断model能否与手牌中的其他牌组成滚龙
- (BOOL)checkIsGunLongModel:(CardModel *)model inHandsCards:(NSArray *)handsCards
{
    BOOL isGlModel = NO;
    
    if (handsCards.count < 12)
    {
        // 滚龙的张数不够
        isGlModel = NO;
    }
    else
    {
        // 滚筒的张数够了，接下来判断是不是滚筒
        NSNumber *numPre1 = [[NSNumber alloc] initWithInteger:model.num - 1];
        NSNumber *numPre2 = [[NSNumber alloc] initWithInteger:model.num - 2];
        NSNumber *numNext1 = [[NSNumber alloc] initWithInteger:model.num + 1];
        NSNumber *numNext2 = [[NSNumber alloc] initWithInteger:model.num + 2];
        
        if ([self checkDArrayContainsNum:numPre1] && [self checkDArrayContainsNum:numPre2] && model.num - 2 >= 3)
        {
            // 第一种情况
            // numPre2\numPre2\numPre2\numPre1numPre1\numPre1\num\num\num
            isGlModel = YES;
        }
        else if ([self checkDArrayContainsNum:numPre1] && [self checkDArrayContainsNum:numNext1] && model.num - 1 >= 3 && model.num + 1 < 15)
        {
            // 第二种情况
            // numPre1\numPre1\numPre1\num\num\num\numNext1\numNext1\numNext1
            isGlModel = YES;
        }
        else if ([self checkDArrayContainsNum:numNext2] && [self checkDArrayContainsNum:numNext1] && model.num + 2 < 15)
        {
            // 第三种情况
            // num\num\num\numNext1\numNext1\numNext1\numNext2\numNext2\numNext2
            isGlModel = YES;
        }
        else
        {
            isGlModel = NO;
        }
    }
    
    return isGlModel;
}

// 判断num是否在bcd三个数组中的其中一个
- (BOOL)checkBcdArrayContainsNum:(NSNumber *)num
{
    BOOL isContains = NO;
    
    if ([self.twoNumArray containsObject:num])
    {
        isContains = YES;
    }
    
    if ([self.threeNumArray containsObject:num])
    {
        isContains = YES;
    }
    
    if ([self.fourNumArray containsObject:num])
    {
        isContains = YES;
    }
    
    return isContains;
}

// 判断num是否在cd两个数组中的其中一个
- (BOOL)checkCdArrayContainsNum:(NSNumber *)num
{
    BOOL isContains = NO;
    
    if ([self.threeNumArray containsObject:num])
    {
        isContains = YES;
    }
    
    if ([self.fourNumArray containsObject:num])
    {
        isContains = YES;
    }
    
    return isContains;
}

// 判断num是否在d数组中
- (BOOL)checkDArrayContainsNum:(NSNumber *)num
{
    BOOL isContains = NO;
    
    if ([self.fourNumArray containsObject:num])
    {
        isContains = YES;
    }
    
    return isContains;
}

@end
