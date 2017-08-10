//
//  MyViewControllerTests.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/10.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "MyViewController.h"
#import "MyTableViewDataSource.h"

@interface MyViewControllerTests : XCTestCase

@end

@implementation MyViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
    tc 2.2.1
 */
- (void)test_PropertyExist_TheTableView{
    objc_property_t theTableViewProperty = class_getProperty([MyViewController class], "theTableView");
    XCTAssertTrue(theTableViewProperty != NULL);
}
/**
 tc 2.2.2
 */
- (void)test_Property_TheTableView_ShouldBeUITableViewType{
    NSString *typeName = [self typeForProperty:@"theTableView" inClass:@"MyViewController"];
    XCTAssertTrue([typeName isEqualToString:@"UITableView"]);
}

/**
 tc 2.2.3
 */
- (void)test_PropertyExist_TheDataSource{
    objc_property_t theTableViewProperty = class_getProperty([MyViewController class], "theDataSource");
    XCTAssertTrue(theTableViewProperty != NULL);
}

/**
 tc 2.2.4
 */
- (void)test_Property_TheDataSource_ShouldConformUITableViewDataSourceAndUITableViewDelegate{
    NSString *typeName = [self typeForProperty:@"theDataSource" inClass:@"MyViewController"];
    XCTAssertTrue([typeName isEqualToString:@"<UITableViewDataSource><UITableViewDelegate>"]);
}
/**
 tc 2.2.5
 */
- (void)test_viewDidLoad_ConnetDataSourceToTableView{
    MyViewController *vc = [[MyViewController alloc] init];
    vc.theTableView = [[UITableView alloc] init];
    vc.theDataSource = [[MyTableViewDataSource alloc] init];
    [vc viewDidLoad];
    XCTAssertTrue(vc.theTableView.dataSource == vc.theDataSource);
}
/**
 tc 2.2.6
 */
- (void)test_viewDidLoad_ConnetDelegateToTableView{
    MyViewController *vc = [[MyViewController alloc] init];
    vc.theTableView = [[UITableView alloc] init];
    vc.theDataSource = [[MyTableViewDataSource alloc] init];
    [vc viewDidLoad];
    XCTAssertTrue(vc.theTableView.delegate == vc.theDataSource);
}

- (NSString *)typeForProperty:(NSString *)pName inClass:(NSString *)cName{
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
        NSString *attr = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
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
