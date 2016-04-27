//
//  ZSTestMultiThreadViewController.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/4/11.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "ZSTestMultiThreadViewController.h"
#import "ThreadSafeCache.h"

#define TIMES 80

@interface ZSTestMultiThreadViewController ()
@property (nonatomic, strong) dispatch_semaphore_t lockSemaphore;

@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, strong) ThreadSafeCache *cache;
@end


@implementation ZSTestMultiThreadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *gcdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gcdButton.frame = CGRectMake(120, 120, 80, 40);
    gcdButton.layer.borderWidth = 1;
    [gcdButton setTitle:@"GCD" forState:UIControlStateNormal];
    [gcdButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [gcdButton addTarget:self action:@selector(gcdTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gcdButton];
    
    UIButton *signalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    signalButton.frame = CGRectMake(120, 180, 80, 40);
    signalButton.layer.borderWidth = 1;
    [signalButton setTitle:@"Signal" forState:UIControlStateNormal];
    [signalButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [signalButton addTarget:self action:@selector(signalTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signalButton];
    
    _lockSemaphore = dispatch_semaphore_create(1);
    self.cache = [ThreadSafeCache new];
    self.data = [NSMutableDictionary dictionary];
}

- (void)lock
{
    dispatch_semaphore_wait(_lockSemaphore, DISPATCH_TIME_FOREVER);
}

- (void)unlock
{
    dispatch_semaphore_signal(_lockSemaphore);
}

- (id)objForKey:(NSString *)key
{
    id obj = nil;
    [self lock];
    obj = self.data[key];
    [self unlock];
    
    return obj;
}

- (void)setObj:(id)obj forKey:(NSString *)key
{
    [self lock];
    self.data[key] = obj;
    [self unlock];
}

- (void)gcdTest
{
    dispatch_queue_t testQueue = dispatch_queue_create([@"GCDTest" UTF8String], DISPATCH_QUEUE_CONCURRENT);
    
    for (NSInteger index = 0; index < TIMES; ++index) {
        
        if (index  == 9) {
            
            dispatch_async(testQueue, ^{
                [self.cache setObject:@(index) ForKey:[@(index) stringValue]];
            });
        }
        else{
            dispatch_async(testQueue, ^{
                [self.cache objectForKey:[@(index) stringValue]];
            });
        }
    }
}

- (void)signalTest
{
    dispatch_queue_t testQueue = dispatch_queue_create([@"SignalTest" UTF8String], DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    for (NSUInteger index = 0; index < 1000; index++) {
        
        dispatch_group_async(group,testQueue, ^{
            if (index % 10 == 9) {
                [self setObj:@(index + 1) forKey:[@(index) stringValue]];
            }
            else{
                [self objForKey:[@(index) stringValue]];
            }
        });
    }
    
    dispatch_group_notify(group, testQueue, ^{
        NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
        NSLog(@"信号量时间：%@",@(end - start));
    });
}

@end
