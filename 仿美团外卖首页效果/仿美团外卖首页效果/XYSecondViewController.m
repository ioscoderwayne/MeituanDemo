//
//  XYSecondViewController.m
//  仿美团外卖首页效果
//
//  Created by weixiaoyang on 2016/11/15.
//  Copyright © 2016年 weixiaoyang. All rights reserved.
//

#import "XYSecondViewController.h"

@interface XYSecondViewController ()

@end

@implementation XYSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    
    UIView *customNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    customNav.backgroundColor = [UIColor redColor];
    [self.view addSubview:customNav];
    
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
