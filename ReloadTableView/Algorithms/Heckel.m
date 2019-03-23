//
//  Heckel.m
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/22.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "Heckel.h"
#import "Entry.h"

@implementation Heckel

- (NSArray *)diff:(NSArray *)oldArray newArray:(NSArray *)newArray {
    NSMutableDictionary *tableDict = [[NSMutableDictionary alloc] init];
    NSMutableArray *oldEntryArray = [[NSMutableArray alloc] init];
    NSMutableArray *newEntryArray = [[NSMutableArray alloc] init];
    [self newPerform:newArray entryArray:newEntryArray dict:tableDict];
    [self oldPerform:oldArray entryArray:oldEntryArray dict:tableDict];
    NSArray *changes = [self newArray:newArray newEntryArray:newEntryArray oldArray:oldArray oldEntryArray:oldEntryArray];
    return changes;
}

- (void)newPerform:(NSArray *)newArray entryArray:(NSMutableArray *)newEntryArray dict:(NSMutableDictionary *)dict {
    for (id item in newArray) {
        Entry *entry = [dict objectForKey:[NSNumber numberWithUnsignedInteger:[item hash]]];
        if (entry == nil) {
            entry = [[Entry alloc] init];
            [dict setObject:entry forKey:[NSNumber numberWithUnsignedInteger:[item hash]]];
        }
        entry.newCount += 1;
        [newEntryArray addObject:entry];
    }
}

- (void)oldPerform:(NSArray *)oldArray entryArray:(NSMutableArray *)oldEntryArray dict:(NSMutableDictionary *)dict {
    for (id item in oldArray) {
        Entry *entry = [dict objectForKey:[NSNumber numberWithUnsignedInteger:[item hash]]];
        if (entry == nil) {
            entry = [[Entry alloc] init];
            [dict setObject:entry forKey:[NSNumber numberWithUnsignedInteger:[item hash]]];
        }
        entry.oldCount += 1;
        [entry.oldIndexArray addObject:[NSNumber numberWithInteger:[oldArray indexOfObject:item]]];
        [oldEntryArray addObject:entry];
    }
}

- (NSArray *)newArray:(NSArray *)newArray
   newEntryArray:(NSMutableArray *)newEntryArray
        oldArray:(NSArray *)oldArray
   oldEntryArray:(NSMutableArray *)oldEntryArray {
    for (Entry *entry in newEntryArray) {
        if (entry.oldIndexArray.count) {
            NSNumber *first = [entry.oldIndexArray objectAtIndex:0];
            [entry.oldIndexArray removeObjectAtIndex:0];
            entry.indexsInOther = [first intValue];
            
        }
    }
    
    NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < oldArray.count; i++) {
        [deleteArray addObject:[NSNumber numberWithInt:0]];
    }
    int deleteCount = 0;
    NSMutableArray *changesArray = [[NSMutableArray alloc] init];
    for (int index = 0; index<oldEntryArray.count; index++) {
        Entry *entry = oldEntryArray[index];
        if (entry.indexsInOther == -1) {
            deleteArray[index] = [NSNumber numberWithInt:deleteCount];
            Delete *change = [[Delete alloc] init];
            change.item = oldArray[index];
            change.type = deleteType;
            change.index = index;
            [changesArray addObject:change];
            deleteCount ++;
        }
    }
    int insertCount = 0;
    for (int index = 0; index<newEntryArray.count; index++) {
        Entry *entry = newEntryArray[index];
        if (entry.indexsInOther == -1) {
            insertCount ++;
            Insert *change = [[Insert alloc] init];
            change.item = newArray[index];
            change.type = insertType;
            change.index = index;
            [changesArray addObject:change];
        } else {
            deleteCount = [deleteArray[entry.indexsInOther] intValue];
            if ((entry.indexsInOther - deleteCount + insertCount) != index) {
                Move *change = [[Move alloc] init];
                change.item = newArray[index];
                change.type = moveType;
                change.toIndex = index;
                change.fromIndex = entry.indexsInOther;
                [changesArray addObject:change];
            }
        }
    }
    return changesArray;
}

@end
