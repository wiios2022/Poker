//
//  LoadingViewController.m
//  BzpPoker
//
//  Created by DengZw on 16/8/29.
//  Copyright © 2016年 ALonelyEgg.com. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()



@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUIView];
    [self userLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUIView
{
    [self.loadingView startAnimating];
}

- (void)userLogin
{
    [self performSelector:@selector(goRoomsViewController) withObject:nil afterDelay:3];
}

- (void)goRoomsViewController
{
    [self.loadingView stopAnimating];
    [self performSegueWithIdentifier:@"GoRoomsViewController" sender:self];
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
