//
//  AiModel.h
//  Poker
//
//  Created by DengZw on 16/7/1.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RoleModel.h"

@interface AiModel : RoleModel

/**< 轮到我出牌 */
- (void)turnToMePlay;

@end
