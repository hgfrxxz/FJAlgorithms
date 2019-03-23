//
//  Heckel.h
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/22.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Change.h"
#import "Insert.h"
#import "Delete.h"
#import "Replace.h"
#import "Move.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heckel : NSObject

- (NSArray *)diff:(NSArray *)oldArray newArray:(NSArray *)newArray;

@end

NS_ASSUME_NONNULL_END
