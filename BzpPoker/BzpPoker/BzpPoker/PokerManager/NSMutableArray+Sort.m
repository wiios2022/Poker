//
//  NSMutableArray+Sort.m
//  Poker
//
//  Created by DengZw on 16/6/30.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray(Sort)


// 洗牌 - 打乱
- (void)shuffleArray
{
    NSInteger count = [self count];
    for (NSInteger i = 0; i < count; ++i)
    {
        NSInteger n = (arc4random() % (count - i)) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
