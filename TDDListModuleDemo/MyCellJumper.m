//
//  MyCellJumper.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/23.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "MyCellJumper.h"

@implementation MyCellJumper

#pragma mark - JumperProtocol

- (instancetype)initWithNavigationController:(UINavigationController *)navVC{
    NSAssert(navVC, @"导航控制器不能为nil");
    if (self = [super init]) {
        _navigationController = navVC;
    }
    
    return self;
}

- (void)toControllerWithData:(id)data{
    
}

@end
