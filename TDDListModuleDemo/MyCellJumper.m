//
//  MyCellJumper.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/23.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "MyCellJumper.h"
#import "MyModel.h"
#import "ATypeViewController.h"
#import "BTypeViewController.h"
#import "CTypeViewController.h"

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
    if (!data || ![data isKindOfClass:[MyModel class]]) {
        return;
    }
    MyModel *model = data;
    UIViewController *vc;
    switch (model.type) {
        case ModelTypeA:
            vc = [[ATypeViewController alloc] init];
            break;
        case ModelTypeB:
            vc = [[BTypeViewController alloc] init];
            break;
        case ModelTypeC:
            vc = [[CTypeViewController alloc] init];
            break;
        default:{
            return;
        }
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
