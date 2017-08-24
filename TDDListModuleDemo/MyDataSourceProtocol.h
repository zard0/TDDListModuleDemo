//
//  MyDataSourceProtocol.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/16.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDataSourceProtocol <NSObject>

@optional
@property (nonatomic, strong) NSArray *theDataArray;
@property (nonatomic, copy) void(^updateBlock)();
@property (nonatomic, copy) void(^cellTapBlock)(id dataModel);

@end
