//
//  FakeTableView.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/16.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "FakeTableView.h"

@implementation FakeTableView


/**
 重写系统方法，让它支持调用时可以被观察
 */
- (void)reloadData{
    [self callMethod:@"reloadData" parameters:nil];
}

@end
