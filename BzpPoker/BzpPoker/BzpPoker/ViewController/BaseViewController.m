//
//  BaseViewController.m
//  Poker
//
//  Created by DengZw on 16/8/1.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImgView.image = [UIImage imageNamed:@"bg_bzp_text"];
    [self.view addSubview:bgImgView];
    [self.view sendSubviewToBack:bgImgView];
    self.bzpBgImgView = bgImgView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (ZwLoadingView *)loadingView
{
    if (!_loadingView)
    {
        _loadingView = [[ZwLoadingView alloc] initWithViewController:self];
    }
    
    return _loadingView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
