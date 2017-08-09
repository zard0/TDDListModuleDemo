//
//  MyModel.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/9.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel

- (NSString *)picUrl{
    switch (self.type) {
        case ModelTypeA:
            return @"AUrl";
            break;
        case ModelTypeB:
            return @"BUrl";
            break;
        case ModelTypeC:
            return @"CUrl";
            break;
        default:
            return nil;
            break;
    }
}

@end
