//
//  RunLoopViewController.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/2/22.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

/*
 自定义一个子线程ZSWorkThread，每次点击按钮都会执行子线程中定义的事件
 **/

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
    button.frame = CGRectMake(100, 100, 200, 50);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"自定义InputSource" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSLog(@"work");
    
    dispatch_semaphore_signal(semaphore);
    
    
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
