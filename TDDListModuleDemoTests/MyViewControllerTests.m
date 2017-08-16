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
#import "NSObject+TestingHelper.h"

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
    NSString *typeName = [NSObject typeForProperty:@"theTableView" inClass:@"MyViewController"];
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
    NSString *typeName = [NSObject typeForProperty:@"theDataSource" inClass:@"MyViewController"];
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


@end
