//
//  FakeNavigationViewController.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/16.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+TestingHelper.h"


@interface FakeNavigationViewController : UINavigationController

/**
 拿到push方法名称

 @return <#return value description#>
 */
+ (NSString *)pushMethodName;

/**
 拿到push方法参数字典的控制器参数的key

 @return <#return value description#>
 */
+ (NSString *)pushControllerParaKey;

/**
 拿到push方法参数字典的是否执行动画参数的key

 @return <#return value description#>
 */
+ (NSString *)pushAnimateParaKey;

@end
