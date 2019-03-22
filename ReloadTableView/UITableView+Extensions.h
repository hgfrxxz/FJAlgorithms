//
//  UITableView+Extensions.h
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/22.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Extensions)

- (void)reload:(NSArray *)changes section:(int)section;

@end

NS_ASSUME_NONNULL_END
