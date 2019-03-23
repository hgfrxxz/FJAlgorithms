//
//  Entry.h
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/22.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Entry : NSObject

@property (nonatomic, assign) int indexsInOther;//-1 表示这个元素没有同时存在新的和旧的数组中
@property (nonatomic, assign) int oldCount;
@property (nonatomic, assign) int newCount;
@property (nonatomic, strong) NSMutableArray *oldIndexArray;

@end

NS_ASSUME_NONNULL_END
