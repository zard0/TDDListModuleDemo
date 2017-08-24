//
//  FakeMyJumper.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/24.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "JumperProtocol.h"
#import "NSObject+TestingHelper.h"

@interface FakeMyJumper : NSObject <JumperProtocol>

/**
 获取常亮的方法名字符串，方便用来做检测对比。

 @return <#return value description#>
 */
+ (NSString *)jumpMethodName;

/**
 从参数字典里面获取model对象的key

 @return <#return value description#>
 */
+ (NSString *)modelKey;

@end
