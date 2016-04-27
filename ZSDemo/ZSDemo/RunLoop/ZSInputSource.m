//
//  ZSInputSource.m
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/2/22.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import "ZSInputSource.h"


void schedule(void *info, CFRunLoopRef rl, CFStringRef mode)
{
    NSLog(@"runLoopSourceSchedule");
}

void cancel(void *info, CFRunLoopRef rl, CFStringRef mode)
{
    NSLog(@"runLoopSourceCancel");
}
              
void perform(void *info)
{
    NSLog(@"runLoopSourcePerform");
}

@interface ZSInputSource ()
@property (nonatomic, assign) CFRunLoopSourceRef runLoopSource;
@end

@implementation ZSInputSource



- (instancetype)init
{
    self = [super init];
    if (self) {
        CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,&schedule,&cancel,&perform};
        
        _runLoopSource = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    }
    
    return self;
}

- (void)addToRunLopp:(CFRunLoopRef)runLoopRef
{
    CFRunLoopAddSource(runLoopRef, _runLoopSource, kCFRunLoopDefaultMode);
}

- (void)fireInputSourceOnRunLoop:(CFRunLoopRef)runLoopRef
{
    CFRunLoopSourceSignal(_runLoopSource);
    CFRunLoopWakeUp(runLoopRef);
}

@end
