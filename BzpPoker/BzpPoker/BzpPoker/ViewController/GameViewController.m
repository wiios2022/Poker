//
//  GameViewController.m
//  Poker
//
//  Created by DengZw on 16/8/1.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "GameViewController.h"

#import "PokerSever.h"
#import "PokerManager.h"
#import "RoleModel.h"

#import "ZwCardView.h"
#import "ZwHandCardsView.h"
#import "ZwDeskCardsView.h"
#import "ZwFoldCardsView.h"

#import "BigCardType.h"

#import "ZwMenuView.h"
#import "GameUserView.h"

#define kViewsSpaceSize 2.0f


@interface GameViewController ()<ZwMenuViewDelegate>
{
    ZwHandCardsView *handCardsView;     // 手牌
    ZwDeskCardsView *u1DeskCardsView;     // 出的牌
    ZwDeskCardsView *u2DeskCardsView;     // 出的牌
    ZwDeskCardsView *u3DeskCardsView;     // 出的牌
    ZwDeskCardsView *u4DeskCardsView;     // 出的牌
    
    UIView *preView;                // 准备界面
    UIView *groupSelfView;          // 包牌界面
    UIView *groupOtherView;         // 分队界面
    UIView *playView;               // 玩牌界面
    
    ZwFoldCardsView *u1FoldCardsView;        // 抢到的牌
    ZwFoldCardsView *u2FoldCardsView;        // 抢到的牌
    ZwFoldCardsView *u3FoldCardsView;        // 抢到的牌
    ZwFoldCardsView *u4FoldCardsView;        // 抢到的牌

}

@property (nonatomic, strong) UIButton *btnDiscard;   /**< 出牌按钮 */

@end

@implementation GameViewController

@synthesize btnDiscard;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUIView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUIView
{
    [UIView animateWithDuration:kHandCardsViewDiscardAnimationTime animations:^{
        
        [self createMenuButtonsView];
        [self createUserInfoView];
        [self createButtonsView];
        
    }];
}

- (void)createMenuButtonsView
{
    ZwMenuView *menuView = [[ZwMenuView alloc] initWithPoint:CGPointMake(self.view.bounds.size.width - 10, 10) delegate:self];
    [self.view addSubview:menuView];
}

- (void)createUserInfoView
{
    // 玩家自己
    CGFloat u1Y = self.view.bounds.size.height - kGameUserViewSizeHeight - kViewsSpaceSize;
    GameUserView *u1View = [[GameUserView alloc] initWithPoint:CGPointMake(kViewsSpaceSize, u1Y) parentVc:self];
    [self.view addSubview:u1View];
    
    // 对面玩家
    CGFloat u3X = self.view.bounds.size.width / 2 - 22;
    GameUserView *u3View = [[GameUserView alloc] initWithPoint:CGPointMake(u3X, kViewsSpaceSize) parentVc:self];
    [self.view addSubview:u3View];
    
    // 右边玩家
    CGFloat u2Y = u3View.frame.origin.y + kGameUserViewSizeHeight + kViewsSpaceSize + (kGameUserViewSizeHeight - kDeskCardViewSizeHeight) / 2 + kDeskCardViewSizeHeight;
    GameUserView *u2View = [[GameUserView alloc] initWithPoint:CGPointMake(self.view.bounds.size.width - kGameUserViewSizeWidth - kViewsSpaceSize, u2Y) parentVc:self];
    [self.view addSubview:u2View];

    // 左边玩家
    GameUserView *u4View = [[GameUserView alloc] initWithPoint:CGPointMake(kViewsSpaceSize, u2Y) parentVc:self];
    [self.view addSubview:u4View];
    
    // 28 * 39
    u1FoldCardsView = [[ZwFoldCardsView alloc] initWithFrame:CGRectMake(kViewsSpaceSize * 2 + kGameUserViewSizeWidth, u1Y + kViewsSpaceSize, kGameUserViewSizeWidth, kGameUserViewSizeHeight - 20)];
    u1FoldCardsView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:u1FoldCardsView];
}

- (void)createHandCardsView
{
    // 牌
    RoleModel *role = [[RoleModel alloc] init];
    [[PokerSever shareSever] linkToSeverByPlayer:role];
    [[PokerSever shareSever] linkToSeverByPlayer:role];
    [[PokerSever shareSever] linkToSeverByPlayer:role];
    [[PokerSever shareSever] linkToSeverByPlayer:role];

    PlayerModel *model = [[PokerSever shareSever] aModel];
    
    // 长度
    CGFloat cardsViewWidth = kCardViewSizeWidth + kCardViewSpaceWidth * 12;
    CGFloat cardsViewHeight = kCardViewSizeHeight + kCardViewPreDiscardHeight;
    
    __weak __block GameViewController *weakSelf = self;
    handCardsView = [[ZwHandCardsView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - cardsViewWidth)/2, self.view.bounds.size.height - cardsViewHeight - kViewsSpaceSize, cardsViewWidth, cardsViewHeight) cards:model.cardsInHandArray];
    [handCardsView setCheckCardTypeBlock:^(BOOL isRight) {
        weakSelf.btnDiscard.enabled = isRight;
    }];
    handCardsView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:handCardsView];
    
}

- (void)createU1DeskCardsView
{
    // 长度
    CGFloat cardsViewWidth = kDeskCardViewSizeWidth + kDeskCardViewSpaceWidth * 13;
    CGFloat cardsViewHeight = kDeskCardViewSizeHeight;
    
    CGFloat orignY = playView.frame.origin.y - cardsViewHeight - kViewsSpaceSize;
    
    u1DeskCardsView = [[ZwDeskCardsView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - cardsViewWidth)/2, orignY, cardsViewWidth, cardsViewHeight) alignment:ZwDeskCardsViewAlignmentCenter];
    
    u1DeskCardsView.backgroundColor = [UIColor lightGrayColor];
    [self.view insertSubview:u1DeskCardsView aboveSubview:self.bzpBgImgView];
}

- (void)createU2DeskCardsView
{
    // 长度
    CGFloat cardsViewWidth = kDeskCardViewSizeWidth + kDeskCardViewSpaceWidth * 13;
    CGFloat cardsViewHeight = kDeskCardViewSizeHeight;
    
    CGFloat orignY = kViewsSpaceSize + kGameUserViewSizeHeight + kViewsSpaceSize + (kGameUserViewSizeHeight - kDeskCardViewSizeHeight) / 2 + kDeskCardViewSizeHeight;
    
    u2DeskCardsView = [[ZwDeskCardsView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - cardsViewWidth - kGameUserViewSizeWidth - kViewsSpaceSize, orignY, cardsViewWidth, cardsViewHeight) alignment:ZwDeskCardsViewAlignmentRight];
    
    u2DeskCardsView.backgroundColor = [UIColor lightGrayColor];
    [self.view insertSubview:u2DeskCardsView aboveSubview:self.bzpBgImgView];
}

- (void)createU3DeskCardsView
{
    // 长度
    CGFloat cardsViewWidth = kDeskCardViewSizeWidth + kDeskCardViewSpaceWidth * 13;
    CGFloat cardsViewHeight = kDeskCardViewSizeHeight;
    
    CGFloat u3Y = kViewsSpaceSize + kGameUserViewSizeHeight + kViewsSpaceSize;
    
    u3DeskCardsView = [[ZwDeskCardsView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - cardsViewWidth)/2, u3Y, cardsViewWidth, cardsViewHeight) alignment:ZwDeskCardsViewAlignmentCenter];
    
    u3DeskCardsView.backgroundColor = [UIColor lightGrayColor];
    [self.view insertSubview:u3DeskCardsView aboveSubview:self.bzpBgImgView];
}

- (void)createU4DeskCardsView
{
    // 长度
    CGFloat cardsViewWidth = kDeskCardViewSizeWidth + kDeskCardViewSpaceWidth * 13;
    CGFloat cardsViewHeight = kDeskCardViewSizeHeight;
    
    CGFloat orignY = kViewsSpaceSize + kGameUserViewSizeHeight + kViewsSpaceSize + (kGameUserViewSizeHeight - kDeskCardViewSizeHeight) / 2 + kDeskCardViewSizeHeight;
    
    u4DeskCardsView = [[ZwDeskCardsView alloc] initWithFrame:CGRectMake(kViewsSpaceSize + kGameUserViewSizeWidth + kViewsSpaceSize, orignY, cardsViewWidth, cardsViewHeight) alignment:ZwDeskCardsViewAlignmentLeft];
    
    u4DeskCardsView.backgroundColor = [UIColor lightGrayColor];
    [self.view insertSubview:u4DeskCardsView aboveSubview:self.bzpBgImgView];
}

- (void)createButtonsView
{
    // 34 * 106
    CGFloat btnWidth = 106;
    CGFloat btnHeight = 34;
    CGFloat btnSpace = kViewsSpaceSize;
    
    CGFloat btnViewWidth = btnWidth * 2 + btnSpace;
    CGFloat btnViewHeight = btnHeight;
    CGFloat btnViewOrignY = self.view.bounds.size.height - (kCardViewSizeHeight + kCardViewPreDiscardHeight + kViewsSpaceSize + btnViewHeight);
    
    preView = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - btnViewWidth)/2, btnViewOrignY, btnViewWidth, btnViewHeight)];
    preView.backgroundColor = [UIColor lightGrayColor];
    preView.alpha = 1;
    
    UIButton *btnChangeDesk = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChangeDesk.frame = CGRectMake(0, 0, btnWidth, btnHeight);
    [btnChangeDesk setBackgroundImage:[UIImage imageNamed:@"btn_game_left"] forState:UIControlStateNormal];
    [btnChangeDesk setTitle:@"换桌" forState:UIControlStateNormal];
    btnChangeDesk.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btnChangeDesk.tintColor = [UIColor whiteColor];
    [btnChangeDesk addTarget:self action:@selector(btnChangeDeskAction:) forControlEvents:UIControlEventTouchUpInside];
    [preView addSubview:btnChangeDesk];
    
    UIButton *btnPrepare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPrepare.frame = CGRectMake(btnWidth + btnSpace, 0, btnWidth, btnHeight);
    [btnPrepare setBackgroundImage:[UIImage imageNamed:@"btn_game_right"] forState:UIControlStateNormal];
    [btnPrepare setTitle:@"准备" forState:UIControlStateNormal];
    btnPrepare.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btnPrepare.tintColor = [UIColor whiteColor];
    [btnPrepare addTarget:self action:@selector(btnPrepareAction:) forControlEvents:UIControlEventTouchUpInside];
    [preView addSubview:btnPrepare];

    [self.view addSubview:preView];
    
    groupSelfView = [[UIView alloc] initWithFrame:preView.frame];
    groupSelfView.backgroundColor = [UIColor lightGrayColor];
    groupSelfView.alpha = 0;
    
    UIButton *btnAlone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAlone.frame = btnChangeDesk.frame;
    [btnAlone setBackgroundImage:[UIImage imageNamed:@"btn_game_left"] forState:UIControlStateNormal];
    [btnAlone setTitle:@"包牌" forState:UIControlStateNormal];
    btnAlone.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btnAlone.tintColor = [UIColor whiteColor];
    [btnAlone addTarget:self action:@selector(btnAloneAction:) forControlEvents:UIControlEventTouchUpInside];
    [groupSelfView addSubview:btnAlone];
    
    UIButton *btnNoAlone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNoAlone.frame = btnPrepare.frame;
    [btnNoAlone setBackgroundImage:[UIImage imageNamed:@"btn_game_right"] forState:UIControlStateNormal];
    [btnNoAlone setTitle:@"不包牌" forState:UIControlStateNormal];
    btnNoAlone.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btnNoAlone.tintColor = [UIColor whiteColor];
    [btnNoAlone addTarget:self action:@selector(btnNoAloneAction:) forControlEvents:UIControlEventTouchUpInside];
    [groupSelfView addSubview:btnNoAlone];
    
    [self.view addSubview:groupSelfView];
    
    playView = [[UIView alloc] initWithFrame:preView.frame];
    playView.backgroundColor = [UIColor lightGrayColor];
    playView.alpha = 0;
    
    UIButton *btnPass = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPass.frame = btnChangeDesk.frame;
    [btnPass setBackgroundImage:[UIImage imageNamed:@"btn_game_left"] forState:UIControlStateNormal];
    [btnPass setBackgroundImage:[UIImage imageNamed:@"btn_game_disabled"] forState:UIControlStateDisabled];
    [btnPass setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnPass setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btnPass setTitle:@"过牌" forState:UIControlStateNormal];
    btnPass.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btnPass addTarget:self action:@selector(btnPassAction:) forControlEvents:UIControlEventTouchUpInside];
    [playView addSubview:btnPass];
    
    btnDiscard = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDiscard.frame = btnPrepare.frame;
    [btnDiscard setBackgroundImage:[UIImage imageNamed:@"btn_game_right"] forState:UIControlStateNormal];
    [btnDiscard setBackgroundImage:[UIImage imageNamed:@"btn_game_disabled"] forState:UIControlStateDisabled];
    [btnDiscard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDiscard setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btnDiscard setTitle:@"出牌" forState:UIControlStateNormal];
    btnDiscard.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btnDiscard addTarget:self action:@selector(btnDiscardAction:) forControlEvents:UIControlEventTouchUpInside];
    btnDiscard.enabled = NO;
    [playView addSubview:btnDiscard];
    
    [self.view addSubview:playView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIButton Action
#pragma mark -

// 换桌
- (void)btnChangeDeskAction:(UIButton *)btn
{
//    [self createUIView];
}

- (void)btnPrepareAction:(UIButton *)btn
{
    [UIView animateWithDuration:kHandCardsViewDiscardAnimationTime animations:^{
        [self createHandCardsView];
        [self createU1DeskCardsView];
        [self createU2DeskCardsView];
        [self createU3DeskCardsView];
        [self createU4DeskCardsView];
        preView.alpha = 0;
        groupSelfView.alpha = 1;
    }completion:^(BOOL finished) {
        [preView removeFromSuperview];
    }];
}

- (void)btnAloneAction:(UIButton *)btn
{
    [UIView animateWithDuration:kHandCardsViewDiscardAnimationTime animations:^{
        groupSelfView.alpha = 0;
        playView.alpha = 1;
    }completion:^(BOOL finished) {
        [groupSelfView removeFromSuperview];
    }];
}

- (void)btnNoAloneAction:(UIButton *)btn
{
    [UIView animateWithDuration:kHandCardsViewDiscardAnimationTime animations:^{
        groupSelfView.alpha = 0;
        playView.alpha = 1;
    }completion:^(BOOL finished) {
        [groupSelfView removeFromSuperview];
    }];
}

- (void)btnPassAction:(UIButton *)btn
{
    NSMutableArray *tmpViewArray = [[NSMutableArray alloc] init];
    
    for (ZwCardView *view in u1DeskCardsView.subviews)
    {
        if ([view isKindOfClass:[ZwCardView class]])
        {
            CGRect frame = view.frame;
            CGRect newFrame = [u1DeskCardsView convertRect:frame toView:self.view];
            view.frame = newFrame;
            [self.view addSubview:view];
            [tmpViewArray addObject:view];
        }
    }
    
    for (ZwCardView *view in u2DeskCardsView.subviews)
    {
        if ([view isKindOfClass:[ZwCardView class]])
        {
            CGRect frame = view.frame;
            CGRect newFrame = [u2DeskCardsView convertRect:frame toView:self.view];
            view.frame = newFrame;
            [self.view addSubview:view];
            [tmpViewArray addObject:view];
        }
    }
    
    for (ZwCardView *view in u3DeskCardsView.subviews)
    {
        if ([view isKindOfClass:[ZwCardView class]])
        {
            CGRect frame = view.frame;
            CGRect newFrame = [u3DeskCardsView convertRect:frame toView:self.view];
            view.frame = newFrame;
            [self.view addSubview:view];
            [tmpViewArray addObject:view];
        }
    }
    
    for (ZwCardView *view in u4DeskCardsView.subviews)
    {
        if ([view isKindOfClass:[ZwCardView class]])
        {
            CGRect frame = view.frame;
            CGRect newFrame = [u4DeskCardsView convertRect:frame toView:self.view];
            view.frame = newFrame;
            [self.view addSubview:view];
            [tmpViewArray addObject:view];
        }
    }
    
    [self gotOneRoundCards:tmpViewArray];
    
    [handCardsView pass];
}

// 获取一轮结束的牌
- (void)gotOneRoundCards:(NSArray *)cards
{
    [self gotOneRoundCards:cards count:0];
}

- (void)gotOneRoundCards:(NSArray *)cards count:(NSInteger)count
{
    NSInteger x = count;
    CGRect toFrame = u1FoldCardsView.frame;
    ZwCardView *view = cards[x];
//    CABasicAnimation *yAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    yAnimation.duration = 0.2f;
//    yAnimation.fromValue = [NSNumber numberWithFloat:-M_PI];
//    yAnimation.toValue = [NSNumber numberWithFloat:M_PI];
//    yAnimation.repeatCount = 1;
//    [view.layer addAnimation:yAnimation forKey:@"yTransform"];
    
    CGFloat animtionTime = kHandCardsViewDiscardAnimationTime / cards.count;
    
    [UIView animateWithDuration:animtionTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = toFrame;
        
    } completion:^(BOOL finished) {
        if (finished)
        {
            NSInteger newCount = count + 1;
            if (newCount < cards.count)
            {
                [self gotOneRoundCards:cards count:newCount];
            }
            else
            {
                [u1DeskCardsView finishedOneRound];
                [u2DeskCardsView finishedOneRound];
                [u3DeskCardsView finishedOneRound];
                [u4DeskCardsView finishedOneRound];
            }
            
            [view removeFromSuperview];
        }
    }];
    
}

- (void)btnDiscardAction:(UIButton *)btn
{
    __weak __block GameViewController *weakSelf = self;
    
    [handCardsView discardByBlock:^(NSMutableArray *cardsViewArray, NSMutableArray *cardsModelArray) {
        [u1DeskCardsView addCards:cardsModelArray];
        [u2DeskCardsView addCards:cardsModelArray];
        [u3DeskCardsView addCards:cardsModelArray];
        [u4DeskCardsView addCards:cardsModelArray];
        
        [u1FoldCardsView setCardsCount:4 * cardsViewArray.count];
        
        NSMutableArray *tmpViewArray = [[NSMutableArray alloc] init];
        NSMutableArray *tmpToFrameArray = [[NSMutableArray alloc] init];
        
        for (ZwCardView *cardView in cardsViewArray)
        {
            CGRect frame = cardView.frame;
            CGRect newFrame = [handCardsView convertRect:frame toView:weakSelf.view];
            ZwCardView *copyView = [cardView duplicateCardView];
            copyView.frame = newFrame;
            [self.view addSubview:copyView];
            [tmpViewArray addObject:copyView];
        }
        
        for (ZwCardView *cardView in u1DeskCardsView.subviews)
        {
            if ([cardView isKindOfClass:[ZwCardView class]])
            {
                for (CardModel *model in cardsModelArray)
                {
                    if (cardView.cardModel == model)
                    {
                        CGRect toFrame = [u1DeskCardsView convertRect:cardView.frame toView:weakSelf.view];
                        NSValue *value = [NSValue valueWithCGRect:toFrame];
                        [tmpToFrameArray addObject:value];
                    }
                }
            }
        }
        
        [UIView animateWithDuration:kHandCardsViewDiscardAnimationTime animations:^{
            for (int x = 0; x < tmpViewArray.count; x ++)
            {
                ZwCardView *view = tmpViewArray[x];
                NSValue *value = tmpToFrameArray[x];
                view.frame = [value CGRectValue];
            }
        }completion:^(BOOL finished) {
            [u1DeskCardsView discardFinished];
            [u2DeskCardsView discardFinished];
            [u3DeskCardsView discardFinished];
            [u4DeskCardsView discardFinished];

            for (ZwCardView *view in tmpViewArray)
            {
                [view removeFromSuperview];
            }
        }];
    }];
    
    if (!handCardsView.cardsArray.count)
    {
        [UIView animateWithDuration:kHandCardsViewDiscardAnimationTime animations:^{
            playView.alpha = 0;
        }completion:^(BOOL finished) {
            [playView removeFromSuperview];
        }];
    }
}

#pragma mark - ZwMenuView Delegate
#pragma mark -

- (void)zwMenuViewSelectedIndex:(NSInteger)index
{
    NSLog(@"%ld", index);
    switch (index)
    {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
}

@end
