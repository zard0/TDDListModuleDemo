//
//  MyTableViewDataSourceTests.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/10.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyTableViewDataSource.h"

@interface MyTableViewDataSourceTests : XCTestCase

@property (nonatomic, strong) MyTableViewDataSource *dataSource;

@end

@implementation MyTableViewDataSourceTests

- (void)setUp {
    [super setUp];
    self.dataSource = [[MyTableViewDataSource alloc] init];
}

- (void)tearDown {
    self.dataSource = nil;
    [super tearDown];
}

- (void)testConformUITableViewDataSourceProtocol{
    XCTAssertTrue([self.dataSource conformsToProtocol:@protocol(UITableViewDataSource)]);
}

- (void)test_ImplMethod_tableView_numberOfRowsInSection{
    XCTAssertTrue([self.dataSource respondsToSelector:@selector(tableView: numberOfRowsInSection:)]);
}

- (void)test_ImplMethod_tableView_cellForRowAtIndexPath{
    XCTAssertTrue([self.dataSource respondsToSelector:@selector(tableView: cellForRowAtIndexPath:)]);
}

- (void)testConformUITableViewDelegateProtocol{
    XCTAssertTrue([self.dataSource conformsToProtocol:@protocol(UITableViewDelegate)]);
}

- (void)test_ImplMethod_tableView_heightForRowAtIndexPath{
    XCTAssertTrue([self.dataSource respondsToSelector:@selector(tableView: heightForRowAtIndexPath:)]);
}

- (void)test_ImplMethod_tableView_didSelectRowAtIndexPath{
    XCTAssertTrue([self.dataSource respondsToSelector:@selector(tableView: didSelectRowAtIndexPath:)]);
}

@end
