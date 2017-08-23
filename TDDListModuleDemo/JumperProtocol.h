//
//  JumperProtocol.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/23.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 跳转类与控制器约定的协议
 */
@protocol JumperProtocol <NSObject>

/**
 各个模块的jumper实现这个方法时，要在方法里面对data做判断，data是想要的数据时，才解析
 拿出数据，执行跳转。

 @param data <#data description#>
 */
- (void)toControllerWithData:(id)data;

/**
 这是应该被使用的正确的初始化方法。
 1，navVC不能为空。
 2，navVC应该在内部被弱引用。

 @param navVC <#navVC description#>
 @return <#return value description#>
 */
- (instancetype)initWithNavigationController:(UINavigationController *)navVC;

@end
