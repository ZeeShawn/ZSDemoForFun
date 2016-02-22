//
//  RunLoopViewController.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/2/22.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "RunLoopViewController.h"
#import "ZSWorkThread.h"

@interface RunLoopViewController ()
@property (nonatomic, strong) ZSWorkThread *workThread;
@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    self.workThread = [[ZSWorkThread alloc] init];
    [self.workThread start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)buttonClicked
{
    [self.workThread doWork];
}

@end
