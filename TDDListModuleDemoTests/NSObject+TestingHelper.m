//
//  NSObject+TestingHelper.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/16.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "NSObject+TestingHelper.h"
#import <objc/runtime.h>

@implementation NSObject (TestingHelper)

/**
 用法：
 1，如果是block类型的属性，这个方法不能识别block的完整sinature，只能告知它是一个block，名字是什么。
 返回的字符串样式是:"Block:[属性名]"。
 2，如果是id<协议1，协议2>类型，返回字符串样式是：“<[协议1]><[协议2]>”。
 3，如果是普通对象属性，返回字符串样式是：“[类名]”。
 
 @param pName <#pName description#>
 @param cName <#cName description#>
 @return <#return value description#>
 */
+ (NSString *)typeForProperty:(NSString *)pName inClass:(NSString *)cName{
    unsigned int count;
    Class checkClass = NSClassFromString(cName);
    objc_property_t* props = class_copyPropertyList(checkClass, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = props[i];
        const char * name = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        if (![propertyName isEqualToString:pName]) {
            continue;
        }
        const char * type = property_getAttributes(property);
        //NSString *attr = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        NSString * typeString = [NSString stringWithUTF8String:type];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        NSString * propertyType = [typeAttribute substringFromIndex:1];
        const char * rawPropertyType = [propertyType UTF8String];
        
        if (strcmp(rawPropertyType, @encode(float)) == 0) {
            //it's a float
        } else if (strcmp(rawPropertyType, @encode(int)) == 0) {
            //it's an int
        } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
            //it's some sort of object
        } else {
            // According to Apples Documentation you can determine the corresponding encoding values
        }
        // 针对block属性
        if ([attributes containsObject:@"T@?"] && [attributes containsObject:[NSString stringWithFormat:@"V_%@",propertyName]]) {
            return [NSString stringWithFormat:@"Block:%@",propertyName];
        }
        
        if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1) {
            NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];  //turns @"NSDate" into NSDate
            
            Class typeClass = NSClassFromString(typeClassName);
            if (typeClass != nil) {
                // Here is the corresponding class even for nil values
            }
            return typeClassName;
        }
        
    }
    free(props);
    return nil;
}


@end
