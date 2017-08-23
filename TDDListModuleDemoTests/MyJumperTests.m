//
//  MyJumperTests.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/23.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyCellJumper.h"

@interface MyJumperTests : XCTestCase

@end

@implementation MyJumperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


/**
 tc 5.3
 */
- (void)test_ShouldConformJumperProtocol{
    MyCellJumper *jumper = [[MyCellJumper alloc] init];
    XCTAssertTrue([jumper conformsToProtocol:@protocol(JumperProtocol)]);
}

/**
 tc 5.4
 */
- (void)test_Method_ToControllerWithData_ShouldBeImplemented{
    MyCellJumper *jumper = [[MyCellJumper alloc] init];
    XCTAssertTrue([jumper respondsToSelector:@selector(toControllerWithData:)]);
}

/**
 tc 5.5
 */
- (void)test_Method_InitWithNavigationController_ShouldBeImplemented{
    MyCellJumper *jumper = [[MyCellJumper alloc] init];
    XCTAssertTrue([jumper respondsToSelector:@selector(initWithNavigationController:)]);
}

/**
 tc 5.6
 */
- (void)test_ShouldNotPassNilWhenInitWithNavigationController{
    XCTAssertThrows([[MyCellJumper alloc] initWithNavigationController:nil]);
}

/**
 tc 5.7
 */
- (void)test_NavigationController_ShouldBeWeaklyRefered{
    __block MyCellJumper *jumper;
    @autoreleasepool {
        UINavigationController *navVC = [[UINavigationController alloc] init];
        jumper = [[MyCellJumper alloc] initWithNavigationController:navVC];
    }
    XCTAssertNil(jumper.navigationController);
}

/**
 tc 5.8
 */
- (void)test_InitMethod_ShouldReturnASelfTypeInstance_And_Property_navigationController_ShouldReferANavigationControllerInstanceAfterInit{
    UINavigationController *navVC = [[UINavigationController alloc] init];
    id obj = [[MyCellJumper alloc] initWithNavigationController:navVC];
    XCTAssertTrue([obj isKindOfClass:[MyCellJumper class]]);
    MyCellJumper *jumper = obj;
    XCTAssertTrue([jumper.navigationController isKindOfClass:[UINavigationController class]]);
}

@end























