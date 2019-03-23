//
//  Change.h
//  SuanfaTest
//
//  Created by taojunfeng on 2019/3/18.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    insertType = 0,
    deleteType,
    replaceType,
    moveType
} ChangeType;

NS_ASSUME_NONNULL_BEGIN

@interface Change : NSObject

@property (nonatomic, assign) ChangeType type;


@end

NS_ASSUME_NONNULL_END
