//
//  Row.m
//  SuanfaTest
//
//  Created by taojunfeng on 2019/3/18.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "Row.h"

@implementation Row

- (instancetype)init {
    self = [super init];
    if (self) {
        _slots = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)seed:(NSArray *)newArray {
    for (int i = 0; i <= newArray.count; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:newArray.count];
        for (int j = 0; j < i; j++) {
            id item = newArray[j];
            Insert *insert = [[Insert alloc] init];
            insert.type = insertType;
            insert.item = item;
            insert.index = i + 1;
            [array addObject:insert];
        }
        [_slots addObject:array];
    }
}

- (void)reset:(id)item count:(int)count atIndex:(int)index {
    if (_slots.count <= 0) {
        for (int i = 0; i <= count; i++) {
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
            [_slots addObject:array];
        }
    }
    Delete *delete = [[Delete alloc] init];
    delete.type = deleteType;
    delete.item = item;
    delete.index = index + 1;
    [_slots[0] addObject:delete];
}


- (void)updateMin:(NSMutableArray <NSMutableArray *>*)previousArray oldIndex:(int)oldIndex oldItem:(id)oldItem newIndex:(int)newIndex newItem:(id)newItem {
    NSMutableArray *topChange = [previousArray[newIndex + 1] mutableCopy];// copy
    NSMutableArray *leftChange = [_slots[newIndex] mutableCopy];// copy
    if (newIndex == oldIndex) {
        if ([oldItem hash] == [newItem hash]) {
            [self update:previousArray newIndex:newIndex];
        } else {
            Replace *replace = [[Replace alloc] init];
            replace.type = replaceType;
            replace.oldItem = oldItem;
            replace.newitem = newItem;
            replace.index = newIndex;
            _slots[newIndex + 1] = [previousArray[newIndex] mutableCopy];
            [_slots[newIndex + 1] addObject:replace];
        }
    } else {
        if (topChange.count >= leftChange.count) {
            Insert *insert = [[Insert alloc] init];
            insert.type = insertType;
            insert.index = newIndex;
            insert.item = newItem;
            [leftChange addObject:insert];
            _slots[newIndex + 1] = leftChange;
        } else {
            Delete *delete = [[Delete alloc] init];
            delete.type = deleteType;
            delete.index = oldIndex;
            delete.item = newItem;
            [topChange addObject:delete];
            _slots[newIndex + 1] = topChange;
        }
    }
}

- (void)update:(NSMutableArray <NSMutableArray *>*)previousArray newIndex:(int)newIndex {
    _slots[newIndex + 1] = previousArray[newIndex];
}

//- (void)move:(NSMutableArray *)changes {
//    NSMutableArray *insertArray = [[NSMutableArray alloc] init];
//    NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
//    for (Change *item in changes) {
//        if (item.type == insertType) {
//            [insertArray addObject:item];
//        } else if (item.type == deleteType) {
//            [deleteArray addObject:item];
//        }
//    }
//    if (insertArray.count == 0 || deleteArray.count == 0) {
//        return;
//    }
//
//    for (Change *insertChange in insertArray) {
//        for (Change *deleteChange in deleteArray) {
//            if (deleteChange.item == insertChange.item) {
//                int insertIndex = (int)[changes indexOfObject:insertChange];
//                int deleteIndex = (int)[changes indexOfObject:deleteChange];
//                Change *moveChange = [[Change alloc] init];
//                moveChange.type = moveType;
//                moveChange.fromItem = insertChange.item;
//                moveChange.fromindex = deleteIndex;
//                moveChange.index = insertIndex;
//                int minIndex = MIN(insertIndex, deleteIndex);
//                int maxIndex = MAX(insertIndex, deleteIndex);
//                [changes objectAtIndex:maxIndex];
//                [changes objectAtIndex:minIndex];
//                [changes insertObject:moveChange atIndex:minIndex];
//            }
//        }
//    }
//}


@end
