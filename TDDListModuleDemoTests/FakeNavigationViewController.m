//
//  FakeNavigationViewController.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/16.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "FakeNavigationViewController.h"


@interface FakeNavigationViewController ()

@end

@implementation FakeNavigationViewController

/**
 重写系统方法，让这个方法的调用可以被验证

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 注意调用一下super方法，否则在执行initWithRootViewController：方法时就不能达到预期效果了。
    [super pushViewController:viewController animated:animated];
    
    [self callMethod:[FakeNavigationViewController pushMethodName]
          parameters:@{
                       [FakeNavigationViewController pushControllerParaKey]:viewController,
                       [FakeNavigationViewController pushAnimateParaKey]:@(animated)}];
}

+ (NSString *)pushMethodName{
    return @"pushViewController:animated:";
}

+ (NSString *)pushControllerParaKey{
    return @"Controller";
}

+ (NSString *)pushAnimateParaKey{
    return @"Animate";
}

@end
