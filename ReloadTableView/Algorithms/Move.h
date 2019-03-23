//
//  Move.h
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/23.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "Change.h"

NS_ASSUME_NONNULL_BEGIN

@interface Move : Change

@property (nonatomic, strong) id item;
@property (nonatomic, assign) int toIndex;
@property (nonatomic, assign) int fromIndex;

@end

NS_ASSUME_NONNULL_END
