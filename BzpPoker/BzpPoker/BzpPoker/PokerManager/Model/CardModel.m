//
//  CardModel.m
//  Poker
//
//  Created by DengZw on 16/7/4.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "CardModel.h"

@implementation CardModel

- (instancetype)initWithTag:(NSString *)tag andNum:(NSInteger)num
{
    if (self = [super init])
    {
        self.tag = tag;
        self.num = num;
    }
    
    return self;
}

@end
