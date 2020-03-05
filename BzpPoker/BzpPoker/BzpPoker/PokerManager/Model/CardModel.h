//
//  CardModel.h
//  Poker
//
//  Created by DengZw on 16/7/4.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject

@property (nonatomic, strong) NSString *tag; /**< 扑克花色 */
@property (nonatomic, assign) NSInteger num; /**< 牌面大小 */

// init
- (instancetype)initWithTag:(NSString *)tag andNum:(NSInteger)num;

@end
