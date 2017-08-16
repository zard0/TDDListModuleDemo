//
//  NSObject+TestingHelper.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/16.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TestingHelper)

/**
 
 用来判断一个类的某个属性的类型是什么
 
 用法：
 1，如果是block类型的属性，这个方法不能识别block的完整sinature，只能告知它是一个block，名字是什么。
 返回的字符串样式是:"Block:[属性名]"。
 2，如果是id<协议1，协议2>类型，返回字符串样式是：“<[协议1]><[协议2]>”。
 3，如果是普通对象属性，返回字符串样式是：“[类名]”。
 
 @param pName 属性名称
 @param cName 类名称
 @return 属性类型标识字符串
 */
+ (NSString *)typeForProperty:(NSString *)pName inClass:(NSString *)cName;

@end
