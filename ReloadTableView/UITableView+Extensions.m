//
//  UITableView+Extensions.m
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/22.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "UITableView+Extensions.h"
#import "Change.h"

@implementation UITableView (Extensions)

- (void)reload:(NSArray *)changes section:(int)section {
    NSMutableArray<NSIndexPath *> *insertArray = [[NSMutableArray alloc] init];
    NSMutableArray<NSIndexPath *> *deleteArray = [[NSMutableArray alloc] init];
    NSMutableArray<NSIndexPath *> *replaceArray = [[NSMutableArray alloc] init];
    NSMutableArray<Change *> *moveArray = [[NSMutableArray alloc] init];
    for (Change *item in changes) {
        @autoreleasepool {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item.index inSection:section];;
            if (item.type == insertType) {
                [insertArray addObject:indexPath];
            } else if (item.type == deleteType) {
                [deleteArray addObject:indexPath];
            } else if (item.type == replaceType) {
                [replaceArray addObject:indexPath];
            } else if (item.type == moveType) {
                [moveArray addObject:item];
            }
        }
    }
    
    [self beginUpdates];
    if (insertArray.count) {
        [self insertRowsAtIndexPaths:insertArray.copy withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (deleteArray.count) {
        [self deleteRowsAtIndexPaths:deleteArray.copy withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (replaceArray.count) {
        [self reloadRowsAtIndexPaths:replaceArray.copy withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    for (Change *item in moveArray) {
        [self moveRowAtIndexPath:[NSIndexPath indexPathForRow:item.fromindex inSection:section] toIndexPath:[NSIndexPath indexPathForRow:item.index inSection:section]];
    }
    [self endUpdates];
}

@end
