//
//  ZSInputSource.h
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/2/22.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSInputSource : NSObject

- (void)fireInputSourceOnRunLoop:(CFRunLoopRef)runLoopRef;
- (void)addToRunLopp:(CFRunLoopRef)runLoopRef;
@end
