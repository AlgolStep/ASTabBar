//
//  FirstViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 PSYDemo. All rights reserved.
//

#import "FirstViewController.h"
#import "FifthViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
        self.title = @"课程";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    first
    UIButton * button = [[UIButton alloc]initWithFrame:self.view.frame];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goOtherView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark 点击按钮进入其他界面

- (void)goOtherView:(UIButton *)sender{
    
    FifthViewController * fifth = [[FifthViewController alloc]init];
    [self.delegate isHiddenCustomTabBarByBoolean:YES];
    [self.navigationController pushViewController:fifth animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.delegate isHiddenCustomTabBarByBoolean:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
