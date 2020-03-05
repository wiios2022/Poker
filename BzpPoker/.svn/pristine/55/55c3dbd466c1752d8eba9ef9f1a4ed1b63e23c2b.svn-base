//
//  RoleModel.h
//  Poker
//
//  Created by DengZw on 16/7/1.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RoleTeamType)
{
    RoleTeamType_A = 0,       // A队
    RoleTeamType_B = 1        // B队
};

@interface RoleModel : NSObject

@property (nonatomic, assign) RoleTeamType teamType; /**< 团队类型 */
@property (nonatomic, assign) BOOL isDiscarded; /**< 当前轮是否出牌 */
@property (nonatomic, strong) NSMutableArray *cardsInHandArray; /**< 手上的牌 */
@property (nonatomic, strong) NSMutableArray *cardsInDeskArray; /**< 桌上的牌，抢到的 */

//- (BOOL)checkHasBigTypeCardsByRole:(RoleModel *)role;


@end
