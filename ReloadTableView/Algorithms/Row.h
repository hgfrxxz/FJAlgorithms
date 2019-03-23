//
//  Row.h
//  SuanfaTest
//
//  Created by taojunfeng on 2019/3/18.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Change.h"
#import "Insert.h"
#import "Delete.h"
#import "Replace.h"
#import "Move.h"

NS_ASSUME_NONNULL_BEGIN

@interface Row : NSObject

@property (nonatomic, strong) NSMutableArray <NSMutableArray *>*slots;

- (void)seed:(NSArray *)newArray;
- (void)reset:(id)item count:(int)count atIndex:(int)index;

- (void)updateMin:(NSMutableArray <NSMutableArray *>*)previousArray oldIndex:(int)oldIndex oldItem:(id)oldItem newIndex:(int)newIndex newItem:(id)newItem;

- (void)update:(NSMutableArray <NSMutableArray *>*)previousArray newIndex:(int)newIndex;

@end

NS_ASSUME_NONNULL_END
