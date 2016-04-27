//
//  ReadWriteLock.h
//  ZSDemo
//
//  Created by zhixiong.sheng on 16/4/15.
//  Copyright © 2016年 盛志雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadWriteLock : NSObject

- (void)lockRead;
- (void)unLockRead;

- (void)lockWrite;
- (void)unLockWrite;

@end
