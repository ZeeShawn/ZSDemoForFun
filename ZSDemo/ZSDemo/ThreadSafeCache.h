//
//  ThreadSafeCache.h
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/4/14.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadSafeCache : NSObject

- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object ForKey:(NSString *)key;

@end
