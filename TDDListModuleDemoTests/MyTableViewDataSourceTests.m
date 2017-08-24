//
//  MyTableViewDataSourceTests.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/10.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyTableViewDataSource.h"
#import "MyCell.h"
#import "NSObject+TestingHelper.h"

@interface MyTableViewDataSourceTests : XCTestCase

@property (nonatomic, strong) MyTableViewDataSource *dataSource;
@property (nonatomic, strong) UITableView *theTableView;

@end

@implementation MyTableViewDataSourceTests

- (void)setUp {
    [super setUp];
    self.dataSource = [[MyTableViewDataSource alloc] init];
    self.theTableView = [[UITableView alloc] init];
    [self.theTableView registerClass:[MyCell class] forCellReuseIdentifier:[MyCell reuseIdentifier]];
}

- (void)tearDown {
    self.dataSource = nil;
    self.theTableView = nil;
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


/**
 tc 3.1
 */
- (void)test_ProvideZeroRowCountWithNilOrEmptyDataArray{
    self.dataSource.theDataArray = nil;
    NSInteger rowCount = [self.dataSource tableView:self.theTableView numberOfRowsInSection:0];
    XCTAssertEqual(rowCount, 0);
    self.dataSource.theDataArray = @[];
    rowCount = [self.dataSource tableView:self.theTableView numberOfRowsInSection:0];
    XCTAssertEqual(rowCount, 0);
}
/**
 tc 3.2
 */
- (void)test_ProvideOneRowCountWithDataArrayContainsOneElement{
    self.dataSource.theDataArray = @[@"first row"];
    NSInteger rowCount = [self.dataSource tableView:self.theTableView numberOfRowsInSection:0];
    XCTAssertEqual(rowCount, 1);
}
/**
 tc 3.3
 */
- (void)test_ProvideTwoRowCountWithDataArrayContainsTwoElement{
    self.dataSource.theDataArray = @[@"first row",@"second row"];
    NSInteger rowCount = [self.dataSource tableView:self.theTableView numberOfRowsInSection:0];
    XCTAssertEqual(rowCount, 2);
}


/**
 tc 3.4
 */
- (void)test_ProvideMyCellInstance{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.dataSource tableView:self.theTableView cellForRowAtIndexPath:indexPath];
    XCTAssertTrue([cell isKindOfClass:[MyCell class]]);
}

/**
 tc 3.5
 */
- (void)test_FirstCellHasFirstDataModel{
    self.dataSource.theDataArray = @[@{@"type":@0,@"title":@"Type A Title",@"someId":@"0001"}];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MyCell *cell = (MyCell *)[self.dataSource tableView:self.theTableView cellForRowAtIndexPath:indexPath];
    XCTAssertTrue([cell.model.someId isEqualToString:@"0001"]);
    XCTAssertTrue(cell.model.type == ModelTypeA);
    XCTAssertTrue([cell.model.picUrl isEqualToString:@"AUrl"]);
    XCTAssertTrue([cell.model.title isEqualToString:@"Type A Title"]);
}

/**
 tc 3.6
 */
- (void)test_SecondCellHasSecondDataModel{
    self.dataSource.theDataArray = @[@{@"type":@0,@"title":@"Type A Title",@"someId":@"0001"},@{@"type":@1,@"title":@"Type B Title",@"someId":@"0002"}];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    MyCell *cell = (MyCell *)[self.dataSource tableView:self.theTableView cellForRowAtIndexPath:indexPath];
    XCTAssertTrue([cell.model.someId isEqualToString:@"0002"]);
    XCTAssertTrue(cell.model.type == ModelTypeB);
    XCTAssertTrue([cell.model.picUrl isEqualToString:@"BUrl"]);
    XCTAssertTrue([cell.model.title isEqualToString:@"Type B Title"]);
}

/**
 tc 3.7
 */
- (void)test_ProvideCellIfTableViewRegistedReusableCell{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.dataSource tableView:self.theTableView cellForRowAtIndexPath:indexPath];
    XCTAssertNotNil(cell);
    XCTAssertTrue([cell isKindOfClass:[MyCell class]]);
}

///**
// tc 3.8 有了tc 3.9，这个测试用例可以去掉了
// */
//- (void)test_DoNotProvideCellIfTableViewDoNotRegistedReusableCell{
//    UITableView *tableView = [[UITableView alloc] init];
//    MyTableViewDataSource *dataSource = [[MyTableViewDataSource alloc] init];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    UITableViewCell *cell = [dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
//    XCTAssertNil(cell);
//}

/**
 tc 3.9
 */
- (void)test_AssertFailureIfTableViewDidNotRegistReuseCell{
    UITableView *tableView = [[UITableView alloc] init];
    MyTableViewDataSource *dataSource = [[MyTableViewDataSource alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    XCTAssertThrows([dataSource tableView:tableView cellForRowAtIndexPath:indexPath]);
}


/**
 tc 4.1
 */
- (void)test_HasAnUpdateBlock{
    NSString *type = [NSObject typeForProperty:@"updateBlock" inClass:@"MyTableViewDataSource"];
    XCTAssertTrue([type isEqualToString:@"Block:updateBlock"]);
}

/**
 tc 4.2
 */
- (void)test_ExecuteUpdateBlockIfExistWhenTheDataArrayUpdated{
    __block BOOL update = NO;
    self.dataSource.updateBlock = ^{
        update = YES;
    };
    self.dataSource.theDataArray = @[];
    XCTAssertTrue(update);
}


/**
 tc 4.4
 */
- (void)test_HasACellTapBlock{
    NSString *type = [NSObject typeForProperty:@"cellTapBlock" inClass:@"MyTableViewDataSource"];
    XCTAssertTrue([type isEqualToString:@"Block:cellTapBlock"]);
}

/**
 tc 4.5
 */
- (void)test_ExecuteCellTapBlockIfCellSelectedMethodCalled{
    __block BOOL called = NO;
    self.dataSource.cellTapBlock = ^(id dataModel){
        called = YES;
    };
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.dataSource tableView:self.theTableView didSelectRowAtIndexPath:indexPath];
    XCTAssertTrue(called);
}

/**
 tc 4.6
 */
- (void)test_CellTapBlockReceiveDataOfTappedCell{
    self.dataSource.theDataArray = @[@{@"type":@0,@"title":@"Type A Title",@"someId":@"0001"},@{@"type":@1,@"title":@"Type B Title",@"someId":@"0002"}];
    __block id model;
    self.dataSource.cellTapBlock = ^(id dataModel){
        model = dataModel;
    };
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.dataSource tableView:self.theTableView didSelectRowAtIndexPath:indexPath];
    XCTAssertNotNil(model);
    XCTAssertTrue([model isKindOfClass:[MyModel class]]);
    MyModel *cellModel = model;
    XCTAssertTrue([cellModel.someId isEqualToString:@"0002"]);
    XCTAssertTrue([cellModel.title isEqualToString:@"Type B Title"]);
    XCTAssertTrue(cellModel.type == ModelTypeB);
}


@end














