//
//  ZSLock.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/4/18.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "ZSLock.h"

@interface ZSLock ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation ZSLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        _semaphore = dispatch_semaphore_create(1);
    }
    
    return  self;
}

- (void)lock
{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

- (void)unlock
{
    dispatch_semaphore_signal(self.semaphore);
}

@end
