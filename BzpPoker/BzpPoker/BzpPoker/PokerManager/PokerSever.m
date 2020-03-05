//
//  PokerSever.m
//  Poker
//
//  Created by DengZw on 16/7/1.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "PokerSever.h"

#import "PokerManager.h"


@interface PokerSever ()
{
    
}

@property (nonatomic, strong) NSMutableArray *playersArray; /**< 玩家数组 */

@property (nonatomic, strong) NSMutableArray *teamAArray; /**< A组队员 */
@property (nonatomic, strong) NSMutableArray *teamBArray; /**< B组队员 */

@end

@implementation PokerSever

#pragma mark - 初始化
#pragma mark -
// 服务器初始化
+ (instancetype)shareSever
{
    static PokerSever *sever = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        sever = [[PokerSever alloc] init];
        sever.playersArray = [[NSMutableArray alloc] init];
        sever.teamAArray = [[NSMutableArray alloc] init];
        sever.teamBArray = [[NSMutableArray alloc] init];
        
        sever.aModel = [[PlayerModel alloc] init];
        sever.bModel = [[AiModel alloc] init];
        sever.cModel = [[AiModel alloc] init];
        sever.dModel = [[AiModel alloc] init];
    });
    
    return sever;
}

#pragma mark - 游戏开始
#pragma mark -
// 玩家连入
- (void)linkToSeverByPlayer:(RoleModel *)player
{
    [self.playersArray addObject:player];
    
    if (self.playersArray.count == 4)
    {
        [self startGame];
    }
}

// 开始游戏
- (void)startGame
{
    // 用来纪录黑桃七那幅牌的index
    NSInteger playerCardsIndex = 0;
    NSMutableArray *array = [[PokerManager shareManager] distributeCardsTo4Players];
    
    for (NSArray *cards in array)
    {
        for (CardModel *model in cards)
        {
            if (model.num == 7 && [model.tag isEqualToString:@"A"])
            {
                playerCardsIndex = [array indexOfObject:cards];
                break;
            }
        }
    }
    
    // 把有黑桃七的牌分配给玩家
    _aModel.cardsInHandArray = array[playerCardsIndex];
    [array removeObjectAtIndex:playerCardsIndex];
    _bModel.cardsInHandArray = array[0];
    _cModel.cardsInHandArray = array[1];
    _dModel.cardsInHandArray = array[2];
    
}

#pragma mark - 分组
#pragma mark -
/**
 *  分组
 *
 *  @param model 如果model为空，则单打; 否则，找出有这张牌的人作为队友
 */
- (void)groupABTeamByCardModel:(nullable CardModel *)model
{
    if (!model)
    {
        _aModel.teamType = RoleTeamType_A;
        [_teamAArray addObject:_aModel];
        
        _bModel.teamType = RoleTeamType_B;
        _cModel.teamType = RoleTeamType_B;
        _dModel.teamType = RoleTeamType_B;
        
        [_teamBArray addObject:_cModel];
        [_teamBArray addObject:_bModel];
        [_teamBArray addObject:_dModel];
    }
    else
    {
        // a
        _aModel.teamType = RoleTeamType_A;
        [_teamAArray addObject:_aModel];
        
        // b
        if ([self checkTeammateByRole:_bModel andCardModel:model])
        {
            _bModel.teamType = RoleTeamType_A;
            [_teamAArray addObject:_bModel];
        }
        else
        {
            _bModel.teamType = RoleTeamType_B;
            [_teamBArray addObject:_bModel];
        }
        
        // c
        if ([self checkTeammateByRole:_cModel andCardModel:model])
        {
            _cModel.teamType = RoleTeamType_A;
            [_teamAArray addObject:_cModel];
        }
        else
        {
            _cModel.teamType = RoleTeamType_B;
            [_teamBArray addObject:_cModel];
        }
        
        // d
        if ([self checkTeammateByRole:_dModel andCardModel:model])
        {
            _dModel.teamType = RoleTeamType_A;
            [_teamAArray addObject:_dModel];
        }
        else
        {
            _dModel.teamType = RoleTeamType_B;
            [_teamBArray addObject:_dModel];
        }
    }
}


// 判断是否队友
- (BOOL)checkTeammateByRole:(RoleModel *)rModel andCardModel:(CardModel *)cModel
{
    BOOL isMate = NO;
    
    if ([rModel.cardsInHandArray containsObject:cModel])
    {
        isMate = YES;
    }
    
    return isMate;
}

#pragma mark - 出牌
#pragma mark -
// 出牌


@end
