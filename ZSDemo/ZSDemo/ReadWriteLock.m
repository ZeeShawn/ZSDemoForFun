//
//  ReadWriteLock.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/4/15.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "ReadWriteLock.h"
#import "ZSLock.h"

@interface ReadWriteLock ()

@property (nonatomic, strong) ZSLock *readLock;
@property (nonatomic, strong) ZSLock *writeLock;

@property (nonatomic, strong) ZSLock *priorityLock;

@property (nonatomic, assign) NSUInteger readCount;
@property (nonatomic, assign) NSUInteger writerCount;

@end

@implementation ReadWriteLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        _readLock = [ZSLock new];
        _writeLock =  [ZSLock new];
        _priorityLock = [ZSLock new];
        _readCount = 0;
    }
    return self;
}

- (void)dealloc
{

}

- (void)lockRead
{
//    [self.priorityLock lock];
    [self.readLock lock];
    
    self.readCount++;
    if (self.readCount == 1) {
        [self.writeLock lock];
    }
    
    [self.readLock unlock];
//    [self.priorityLock unlock];
}

- (void)unLockRead
{
    [self.readLock lock];
    
    self.readCount--;
    if (self.readCount == 0) {
        [self.writeLock unlock];
    }
    
    [self.readLock unlock];
}

- (void)lockWrite
{
//    [self.priorityLock lock];

    [self.writeLock lock];
}

- (void)unLockWrite
{
    [self.writeLock unlock];
//    [self.priorityLock unlock];
}

@end
