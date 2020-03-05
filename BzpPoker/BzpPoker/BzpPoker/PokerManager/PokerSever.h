//
//  PokerSever.h
//  Poker
//
//  Created by DengZw on 16/7/1.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AiModel.h"
#import "PlayerModel.h"
#import "RoleModel.h"

@interface PokerSever : NSObject

@property (nonatomic, strong) PlayerModel *aModel;
@property (nonatomic, strong) AiModel *bModel;
@property (nonatomic, strong) AiModel *cModel;
@property (nonatomic, strong) AiModel *dModel;

// 服务器初始化
+ (instancetype)shareSever;

// 玩家连入
- (void)linkToSeverByPlayer:(RoleModel *)player;

// 开始
- (void)startGame;

// 发牌



// 洗牌

// 确认庄家

// 玩家请求

// 

// 比赛胜利

@end
