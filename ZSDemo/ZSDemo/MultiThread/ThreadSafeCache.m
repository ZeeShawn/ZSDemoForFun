//
//  ThreadSafeCache.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/4/14.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "ThreadSafeCache.h"
#import "ReadWriteLock.h"

@interface ThreadSafeCache ()
@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) ReadWriteLock *lock;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;
@end

@implementation ThreadSafeCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = [NSMutableDictionary dictionary];
        _concurrentQueue = dispatch_queue_create("ReadWriteQueue",DISPATCH_QUEUE_CONCURRENT);
        _lock = [ReadWriteLock new];
    }
    
    return self;
}

- (id)objectForKey:(NSString *)key
{
    [self.lock lockRead];
    NSLog(@"GetStart:%@",key);
    
    id obj = nil;
    obj = [self.data objectForKey:key];
    
    [self.lock unLockRead];
    return obj;
}

- (void)setObject:(id)object ForKey:(NSString *)key
{
    [self.lock lockWrite];
    NSLog(@"SetStart:%@",key);
    [self.data setObject:object forKey:key];
    
    [self.lock unLockWrite];
}


@end
