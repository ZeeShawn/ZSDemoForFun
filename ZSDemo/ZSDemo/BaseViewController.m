//
//  BaseViewController.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/4/1.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *classString = NSStringFromClass(self.class);
    
    NSLog(@"%@",classString);
    
}

@end
