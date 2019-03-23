//
//  Insert.h
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/23.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "Change.h"

NS_ASSUME_NONNULL_BEGIN

@interface Insert : Change

@property (nonatomic, strong) id item;
@property (nonatomic, assign) int index;

@end

NS_ASSUME_NONNULL_END
