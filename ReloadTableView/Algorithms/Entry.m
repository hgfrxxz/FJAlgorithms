//
//  Entry.m
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/22.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "Entry.h"

@implementation Entry

- (instancetype)init {
    if (self = [super init]) {
        _indexsInOther = -1;
        _oldCount = 0;
        _newCount = 0;
        _oldIndexArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
