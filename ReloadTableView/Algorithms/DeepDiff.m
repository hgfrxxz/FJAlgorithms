//
//  DeepDiff.m
//  SuanfaTest
//
//  Created by taojunfeng on 2019/3/18.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "DeepDiff.h"
#import "Row.h"

@implementation DeepDiff

- (NSArray *)diff:(NSArray *)oldArray newArray:(NSArray *)newArray {
    Row *previousRow = [[Row alloc] init];
    [previousRow seed:newArray];
    Row *currentRow = [[Row alloc] init];
    
    for (int i = 0; i < oldArray.count; i++) {
        [currentRow reset:oldArray[i] count:(int)newArray.count atIndex:i];
        for (int j = 0; j < newArray.count; j++) {
            [currentRow updateMin:previousRow.slots oldIndex:i oldItem:oldArray[i] newIndex:j newItem:newArray[j]];
        }
        for (int i = 0; i< currentRow.slots.count; i++) {
            previousRow.slots[i] = [currentRow.slots[i] mutableCopy];
        }
    }
    NSMutableArray *changes = [currentRow.slots lastObject];
//    [currentRow move:changes]; 移动 = （insert 和 delete 相同元素时）
    return [changes copy];
}

@end
