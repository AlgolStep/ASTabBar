//
//  ASViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 PSYDemo. All rights reserved.
//

#import "TVBViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#import "TVBTabBarItem.h"

static NSString *tabTitleKey = @"title";
static NSString *tabNormalImageKey = @"normalImage";
static NSString *tabSelectedImageKey = @"selectedImage";
// 绿色
#define GREENCOLOR [UIColor \
colorWithRed:9.0/255.0 \
green:164.0/255.0 \
blue:82.0/255.0 \
alpha:1.0]

@interface TVBViewController (){


}

@end

@implementation TVBViewController

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
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:GREENCOLOR,NSForegroundColorAttributeName,nil]
                                             forState:UIControlStateSelected];
    
    FirstViewController * first = [[FirstViewController alloc]init];
    SecondViewController * second = [[SecondViewController alloc]init];
    ThirdViewController * third = [[ThirdViewController alloc]init];
    FourthViewController * fourth = [[FourthViewController alloc]init];
    
    
    NSArray *viewControllers = @[first,second,third,fourth];
    NSArray *resArray = [self tabBarItemShowArray];
    NSMutableArray *viewNavControlles = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *cViewController = viewControllers[i];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cViewController];
        NSDictionary *resDic = resArray[i];
        nav.tabBarItem = [self loadTabBarRes:resDic];
        [viewNavControlles addObject:nav];
    }
    
    self.viewControllers = viewNavControlles;
    self.selectedIndex = 0;
}


- (NSArray *)tabBarItemShowArray{
    NSArray *array = [NSArray arrayWithObjects:
                      @{tabTitleKey:@"课程",tabNormalImageKey:@"SZ_kc",tabSelectedImageKey:@"SZ_kcH"},
                      @{tabTitleKey:@"产品",tabNormalImageKey:@"SZ_QS",tabSelectedImageKey:@"SZ_QSH"},
                      @{tabTitleKey:@"信息",tabNormalImageKey:@"SZ_time",tabSelectedImageKey:@"SZ_timeH"},
                      @{tabTitleKey:@"个人中心",tabNormalImageKey:@"SZ_TS",tabSelectedImageKey:@"SZ_TSH"}, nil];
    return array;
}

#pragma mark 创建一个Item
- (TVBTabBarItem *)loadTabBarRes:(NSDictionary *)dic{
    
    TVBTabBarItem *tvbTabBarItem = [[TVBTabBarItem alloc] initWithTitle:dic[tabTitleKey]
                                                                 imageName:dic[tabNormalImageKey]
                                                         selectedImageName:dic[tabSelectedImageKey]];
    return tvbTabBarItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
