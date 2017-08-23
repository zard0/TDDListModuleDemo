//
//  AppDelegateTests.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/16.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "MyViewController.h"
#import "MyTableViewDataSource.h"

@interface AppDelegateTests : XCTestCase

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navVC;
@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation AppDelegateTests

- (void)setUp {
    [super setUp];
    self.window = [[UIWindow alloc] init];
    self.appDelegate = [[AppDelegate alloc] init];
    self.appDelegate.window = self.window;
}

- (void)tearDown {
    self.window = nil;
    self.appDelegate = nil;
    [super tearDown];
}


/**
 tc 7.1
 */
- (void)testWindowIsKeyAfterApplicationLaunch{
    [self.appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    XCTAssertTrue(self.appDelegate.window.keyWindow);
}

/**
 tc 7.2
 */
- (void)testApplicationDidFinishLaunchingWithOptionsReturnYes{
    XCTAssertTrue([self.appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil]);
}

/**
 tc 7.3
 */
- (void)testWindowHasRootNavigationControllerAterApplicationLaunch{
    [self.appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    XCTAssertTrue([self.appDelegate.window.rootViewController isKindOfClass:[UINavigationController class]]);
}

/**
 tc 7.4
 */
- (void)testNavigationControllerShowsAMyViewController{
    [self.appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    id visibleVC = [(UINavigationController *)self.appDelegate.window.rootViewController topViewController];
    XCTAssertTrue([visibleVC isKindOfClass:[MyViewController class]]);
}

/**
 tc 7.5
 */
- (void)testVisibleMyViewControllerHasADataSource{
    [self.appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    MyViewController *visibleVC = (MyViewController *)[(UINavigationController *)self.appDelegate.window.rootViewController topViewController];
    XCTAssertNotNil(visibleVC.theDataSource);
    XCTAssertTrue([visibleVC.theDataSource isKindOfClass:[MyTableViewDataSource class]]);
}

/**
 tc 7.6
 */
- (void)testDataSourceHasDatas{
    [self.appDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
    MyViewController *visibleVC = (MyViewController *)[(UINavigationController *)self.appDelegate.window.rootViewController topViewController];
    XCTAssertTrue([visibleVC.theDataSource.theDataArray count] > 0);
}

@end

























