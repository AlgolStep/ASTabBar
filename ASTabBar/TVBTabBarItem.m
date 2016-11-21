//
//  KKBCTabBarItem.m
//  ASTabBar
//
//  Created by 王绵杰 on 2016/11/17.
//  Copyright © 2016年 PSYDemo. All rights reserved.
//

#import "TVBTabBarItem.h"

@implementation TVBTabBarItem


- (id)initWithTitle:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selectedImage{
    self = [super initWithTitle:title image:[UIImage imageNamed:image]
                  selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    if (self) {
        
        self.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    }
    return  self;
}


- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    self = [super initWithTitle:title image:image
                  selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    if (self) {
        self.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    }
    return  self;
}
@end
