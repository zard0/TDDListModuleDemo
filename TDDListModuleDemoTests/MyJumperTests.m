//
//  MyJumperTests.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/23.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyCellJumper.h"
#import "MyModel.h"
#import "FakeNavigationViewController.h"
#import "ATypeViewController.h"
#import "BTypeViewController.h"
#import "CTypeViewController.h"

@interface MyJumperTests : XCTestCase

@property (nonatomic, strong) UINavigationController *navVC;
@property (nonatomic, strong) FakeNavigationViewController *fakeNavVC;
@property (nonatomic, strong) MyCellJumper *jumper;
@property (nonatomic, strong) MyCellJumper *jumperWithFakeNavVC;
@property (nonatomic, strong) UIViewController *pushedController;
@property (nonatomic, strong) NSString *pushMethod;

@end

@implementation MyJumperTests

- (void)setUp {
    [super setUp];
    // 依赖于可测试导航栏控制器的jumper
    self.fakeNavVC = [[FakeNavigationViewController alloc] init];
    __weak typeof(self) wSelf = self;
    self.fakeNavVC.callMethodBlock = ^(NSString *methodName, NSDictionary *parameters) {
        __strong typeof(self) sSelf = wSelf;
        sSelf.pushMethod = methodName;
        sSelf.pushedController = parameters[[FakeNavigationViewController pushControllerParaKey]];
    };
    self.jumperWithFakeNavVC = [[MyCellJumper alloc] initWithNavigationController:self.fakeNavVC];
    // 正常的jumper
    self.navVC = [[UINavigationController alloc] init];
    self.jumper = [[MyCellJumper alloc] initWithNavigationController:self.navVC];
}

- (void)tearDown {
    self.navVC = nil;
    self.jumper = nil;
    self.pushedController = nil;
    self.pushMethod = nil;
    [super tearDown];
}


/**
 tc 5.3
 */
- (void)test_ShouldConformJumperProtocol{
    XCTAssertTrue([self.jumper conformsToProtocol:@protocol(JumperProtocol)]);
}

/**
 tc 5.4
 */
- (void)test_Method_ToControllerWithData_ShouldBeImplemented{
    XCTAssertTrue([self.jumper respondsToSelector:@selector(toControllerWithData:)]);
}

/**
 tc 5.5
 */
- (void)test_Method_InitWithNavigationController_ShouldBeImplemented{
    XCTAssertTrue([self.jumper respondsToSelector:@selector(initWithNavigationController:)]);
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

/**
 tc 5.9
 */
- (void)test_Method_ToControllerWithData_DoNotPushWithNil{
    [self.jumperWithFakeNavVC toControllerWithData:nil];
    XCTAssertNil(self.pushMethod);
}

/**
 tc 5.10
 */
- (void)test_Method_ToControllerWithData_DoNotPushWithNotMyModelTypeData{
    NSObject *otherPara = [[NSObject alloc] init];
    [self.jumperWithFakeNavVC toControllerWithData:otherPara];
    XCTAssertNil(self.pushMethod);
}

/**
 tc 5.11
 */
- (void)test_JumpToATypeViewController_WithATypeData{
    MyModel *model = [[MyModel alloc] init];
    model.type = ModelTypeA;
    [self.jumperWithFakeNavVC toControllerWithData:model];
    XCTAssertTrue([self.pushMethod isEqualToString:[FakeNavigationViewController pushMethodName]]);
    XCTAssertTrue([self.pushedController isKindOfClass:[ATypeViewController class]]);
}

/**
 tc 5.12
 */
- (void)test_JumpToBTypeViewController_WithBTypeData{
    MyModel *model = [[MyModel alloc] init];
    model.type = ModelTypeB;
    [self.jumperWithFakeNavVC toControllerWithData:model];
    XCTAssertTrue([self.pushMethod isEqualToString:[FakeNavigationViewController pushMethodName]]);
    XCTAssertTrue([self.pushedController isKindOfClass:[BTypeViewController class]]);
}

/**
 tc 5.13
 */
- (void)test_JumpToCTypeViewController_WithCTypeData{
    MyModel *model = [[MyModel alloc] init];
    model.type = ModelTypeC;
    [self.jumperWithFakeNavVC toControllerWithData:model];
    XCTAssertTrue([self.pushMethod isEqualToString:[FakeNavigationViewController pushMethodName]]);
    XCTAssertTrue([self.pushedController isKindOfClass:[CTypeViewController class]]);
}

/**
 tc 5.14
 */
- (void)test_DoNotPushWhenMyModelTypeDataWithOtherTypeValue{
    MyModel *model = [[MyModel alloc] init];
    model.type = 100;
    [self.jumperWithFakeNavVC toControllerWithData:model];
    XCTAssertNil(self.pushMethod);
    XCTAssertNil(self.pushedController);
}

@end


































