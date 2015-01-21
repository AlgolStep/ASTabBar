//
//  ASViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 PSYDemo. All rights reserved.
//

#import "ASViewController.h"
#import "ASButton.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ASViewController (){

    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    
    ASButton * _previousBtn;//记录前一次选中的按钮

}

@end

@implementation ASViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    CGFloat tabBarViewY = self.view.frame.size.height - 48;
    
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tabBarViewY, self.view.frame.size.width, 48)];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.image = [UIImage imageNamed:@"title_background.png"];
    _tabBarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tabBarView];
    
    FirstViewController * first = [[FirstViewController alloc]init];
    first.delegate = self;
    UINavigationController * navigationFirst = [[UINavigationController alloc] initWithRootViewController:first];
    SecondViewController * second = [[SecondViewController alloc]init];
    UINavigationController * navigationSecond = [[UINavigationController alloc] initWithRootViewController:second];
    ThirdViewController * third = [[ThirdViewController alloc]init];
    UINavigationController * navigationThird = [[UINavigationController alloc] initWithRootViewController:third];
    FourthViewController * fourth = [[FourthViewController alloc]init];
    UINavigationController * navigationForth = [[UINavigationController alloc] initWithRootViewController:fourth];
    
    self.viewControllers = [NSArray arrayWithObjects:navigationFirst,navigationSecond,navigationThird,navigationForth, nil];
    
    [self creatButtonWithNormalName:@"SZ_kc" andSelectName:@"SZ_kcH" andTitle:@"课程" andIndex:0];
    [self creatButtonWithNormalName:@"SZ_QS" andSelectName:@"SZ_QSH" andTitle:@"产品" andIndex:1];
    [self creatButtonWithNormalName:@"SZ_time" andSelectName:@"SZ_timeH" andTitle:@"信息" andIndex:2];
    [self creatButtonWithNormalName:@"SZ_TS" andSelectName:@"SZ_TSH" andTitle:@"设置" andIndex:3];
    ASButton * button = _tabBarView.subviews[0];
    [self changeViewController:button];
}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    ASButton * customButton = [ASButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = _tabBarView.frame.size.width / 4;
    CGFloat buttonH = _tabBarView.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    customButton.frame = CGRectMake(frameWidth/4 * index, 0, buttonW+4, buttonH+4);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    [customButton setTitle:title forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeTop;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
;
   
    [_tabBarView addSubview:customButton];

}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(ASButton *)sender
{
    self.selectedIndex = sender.tag; //切换不同控制器的界面
//    buttonItem 被点击后即处于不可触发状态，此时的状态就是所谓的Disabled 这是设置颜色为高亮
    [sender setTitleColor:[UIColor colorWithRed:10.0/255.0
                                          green:145.0/255.0
                                           blue:55.0/255.0
                                          alpha:1.0f]
                 forState:UIControlStateDisabled];
    sender.enabled = NO;
    if (_previousBtn != sender) {
        _previousBtn.enabled = YES;
    }
    _previousBtn = sender;
    
    self.selectedViewController = self.viewControllers[sender.tag];
}

#pragma mark 是否隐藏tabBar

-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean{
    
    _tabBarView.hidden=boolean;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
