//
//  MyModel.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/9.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ModelType){
    ModelTypeA = 0,
    ModelTypeB,
    ModelTypeC
};

@interface MyModel : NSObject

@property (nonatomic, assign) ModelType type;
@property (nonatomic, copy) NSString *picUrl;

@end
