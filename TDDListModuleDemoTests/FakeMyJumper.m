//
//  FakeMyJumper.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/24.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "FakeMyJumper.h"

@implementation FakeMyJumper

#pragma mark - JumperProtocol

- (void)toControllerWithData:(id)data{
    // 调用了本方法，外界就能检测到
    if (self.callMethodBlock) {
        self.callMethodBlock([FakeMyJumper jumpMethodName], @{[FakeMyJumper modelKey]:data});
    }
}

- (instancetype)initWithNavigationController:(UINavigationController *)navVC{
    return self;
}

+ (NSString *)jumpMethodName{
    return @"toControllerWithData:";
}

+ (NSString *)modelKey{
    return @"dataModel";
}

@end
