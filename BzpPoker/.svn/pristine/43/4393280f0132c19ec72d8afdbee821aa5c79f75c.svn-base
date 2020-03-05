//
//  AssociatedCardType.m
//  Poker
//
//  Created by DengZw on 16/8/4.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "AssociatedCardType.h"

@implementation AssociatedCardType

#pragma mark - 联想牌型
#pragma mark -

- (NSMutableArray *)gotAssociatedCardsByHandsCards:(NSArray *)handsCards
                                     selectedCards:(NSArray *)selectedCards
                                        otherCards:(NSArray *)otherCards
{
    NSMutableArray *associatedCards = [[NSMutableArray alloc] init];
    
    if (!otherCards)
    {
        associatedCards = [self gotSelfDiscardAssociatedCardsByHandsCards:handsCards
                                                            selectedCards:selectedCards
                                                               otherCards:otherCards];
    }
    else
    {
        associatedCards = [self gotOtherDiscardAssociatedCardsByHandsCards:handsCards
                                                             selectedCards:selectedCards
                                                                otherCards:otherCards];
    }
    
    return associatedCards;
}

// 自己出牌时的联想牌型
- (NSMutableArray *)gotSelfDiscardAssociatedCardsByHandsCards:(NSArray *)handsCards
                                                selectedCards:(NSArray *)selectedCards
                                                   otherCards:(NSArray *)otherCards
{
    NSMutableArray *associatedCards = [[NSMutableArray alloc] init];
    return associatedCards;
}

// 别人出牌时的联想牌型
- (NSMutableArray *)gotOtherDiscardAssociatedCardsByHandsCards:(NSArray *)handsCards
                                                 selectedCards:(NSArray *)selectedCards
                                                    otherCards:(NSArray *)otherCards
{
    NSMutableArray *associatedCards = [[NSMutableArray alloc] init];
    return associatedCards;
}

@end
