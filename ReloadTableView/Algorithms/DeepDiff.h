//
//  DeepDiff.h
//  SuanfaTest
//
//  Created by taojunfeng on 2019/3/18.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Change.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeepDiff : NSObject

- (NSArray *)diff:(NSArray *)oldArray newArray:(NSArray *)newArray;

@end

NS_ASSUME_NONNULL_END
