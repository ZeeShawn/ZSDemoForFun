//
//  ZSWorkThread.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/2/22.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "ZSWorkThread.h"
#import "ZSInputSource.h"

@interface ZSWorkThread ()
@property (nonatomic, strong) ZSInputSource *inputSource;
@property (nonatomic, assign) CFRunLoopRef currentRunLoop;
@end

@implementation ZSWorkThread

- (void)main
{
    _currentRunLoop = CFRunLoopGetCurrent();
    
    self.inputSource = [[ZSInputSource alloc] init];
    [self.inputSource addToRunLopp:_currentRunLoop];
    
    while (!self.isCancelled) {
        [self reallyDoWork];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)doWork
{
    [self.inputSource fireInputSourceOnRunLoop:_currentRunLoop];
}

- (void)reallyDoWork
{
    NSLog(@"I'm working in thread:%@",[NSThread currentThread]);
}

@end
