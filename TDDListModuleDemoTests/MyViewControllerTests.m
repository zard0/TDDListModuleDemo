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
#import "FakeTableView.h"
#import "ATypeViewController.h"
#import "FakeNavigationViewController.h"
#import "MyCell.h"


@interface MyViewControllerTests : XCTestCase

@property (nonatomic, strong) UITableView *theTableView;
@property (nonatomic, strong) MyTableViewDataSource *theDataSource;
@property (nonatomic, strong) MyViewController *theController;

@end

@implementation MyViewControllerTests

- (void)setUp {
    [super setUp];
    self.theTableView = [[UITableView alloc] init];
    self.theDataSource = [[MyTableViewDataSource alloc] init];
    self.theController = [[MyViewController alloc] init];
}

- (void)tearDown {
    self.theDataSource = nil;
    self.theTableView = nil;
    self.theController = nil;
    [super tearDown];
}

#pragma mark - 重用方法

/**
 这部分重用代码我不写在setUp方法，而要写成这个公共方法来让测试用例调用，因为：
 1，这部分代码只适合一部分测试用例使用，在用不上setUp里面这些代码的测试用例要减少它们执行无谓的代码的时间。
 2，这部分代码也是测试用例比较重要的前置步骤，如果写在setUp，以后查看相关测试用例代码时，可能不自觉会忽略这些前置条件，降低了代码的说明性。
 */
- (void)setupDataSourceAndTableViewThenDoViewDidLoad{
    self.theController.theTableView = self.theTableView;
    self.theController.theDataSource = self.theDataSource;
    [self.theController viewDidLoad];
}

#pragma mark - 测试用例

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
    // 旧的验证
    //XCTAssertTrue([typeName isEqualToString:@"<UITableViewDataSource><UITableViewDelegate>"]);
    // 新的验证
    XCTAssertTrue([typeName isEqualToString:@"<UITableViewDataSource><UITableViewDelegate><MyDataSourceProtocol>"]);
}
/**
 tc 2.2.5
 */
- (void)test_viewDidLoad_ConnetDataSourceToTableView{
    [self setupDataSourceAndTableViewThenDoViewDidLoad];
    XCTAssertTrue(self.theController.theTableView.dataSource == self.theController.theDataSource);
}
/**
 tc 2.2.6
 */
- (void)test_viewDidLoad_ConnetDelegateToTableView{
    [self setupDataSourceAndTableViewThenDoViewDidLoad];
    XCTAssertTrue(self.theController.theTableView.delegate == self.theController.theDataSource);
}

/**
 tc 4.3
 */
- (void)test_reloadTableViewWhenDataSouceGetNewData{
    FakeTableView *tableView = [[FakeTableView alloc] init];
    __block NSString *calledMethod;
    tableView.callMethodBlock = ^(NSString *methodName, NSDictionary *parameters) {
        calledMethod = methodName;
    };
    self.theController.theTableView = tableView;
    self.theController.theDataSource = self.theDataSource;
    [self.theController viewDidLoad];
    self.theDataSource.theDataArray = @[];
    XCTAssertTrue([calledMethod isEqualToString:@"reloadData"]);
}

/**
 tc 4.7 
 这种测试方式要求[self.navigationController pushViewController:vc animated:NO]
 的animated:参数只能传NO,否则控制器不会push成功。
 */
//- (void)test_pushATypeViewControllerIfTapATypeCell{
//    MyViewController *myVC = [[MyViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:myVC];
//    MyTableViewDataSource *dataSource = [[MyTableViewDataSource alloc] init];
//    UITableView *tableView = [[UITableView alloc] init];
//    myVC.theTableView = tableView;
//    myVC.theDataSource = dataSource;
//    [myVC viewDidLoad];
//    myVC.theDataSource.theDataArray = @[@{@"type":@0,@"title":@"Type A Title",@"someId":@"0001"},@{@"type":@1,@"title":@"Type B Title",@"someId":@"0002"}];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [myVC.theDataSource tableView:myVC.theTableView didSelectRowAtIndexPath:indexPath];
//    XCTAssertTrue([myVC.navigationController.topViewController isKindOfClass:[ATypeViewController class]]);
//}

/**
 tc 4.8
 */
- (void)test_pushMethodIsCalledWithATypeViewControllerIfTapATypeCell{
    FakeNavigationViewController *nav = [[FakeNavigationViewController alloc] initWithRootViewController:self.theController];
    __block NSString *name;
    __block NSDictionary *paras;
    nav.callMethodBlock = ^(NSString *methodName, NSDictionary *parameters) {
        name = methodName;
        paras = parameters;
    };
    [self setupDataSourceAndTableViewThenDoViewDidLoad];
    self.theController.theDataSource.theDataArray = @[@{@"type":@0,@"title":@"Type A Title",@"someId":@"0001"},@{@"type":@1,@"title":@"Type B Title",@"someId":@"0002"}];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.theController.theDataSource tableView:self.theController.theTableView didSelectRowAtIndexPath:indexPath];
    XCTAssertTrue([name isEqualToString:[FakeNavigationViewController pushMethodName]]);
    XCTAssertTrue([paras[[FakeNavigationViewController pushControllerParaKey]] isKindOfClass:[ATypeViewController class]]);
    XCTAssertEqual([paras[[FakeNavigationViewController pushAnimateParaKey]] boolValue] , YES);
}

/**
 tc 5.1
 */
- (void)test_Property_TheJumper_ConformJumperProtocol{
    NSString *typeName = [NSObject typeForProperty:@"theJumper" inClass:@"MyViewController"];
    XCTAssertTrue([typeName isEqualToString:@"<JumperProtocol>"]);
}

/**
 tc 5.2
 */
- (void)test_Property_TheJumper_IsStronglyRefered{
    @autoreleasepool {
        self.theController.theJumper = (id<JumperProtocol>)[[NSObject alloc] init];
    }
    // weak引用，会被自动释放池释放，强引用不会。
    XCTAssertNotNil(self.theController.theJumper);
}

/**
 tc 7.7
 */
- (void)test_ExistTableViewAfterViewDidLoad{
    [self.theController viewDidLoad];
    XCTAssertNotNil(self.theController.theTableView);
}

/**
 tc 7.8
 */
- (void)test_TableViewAddedToViewAfterViewDidLoad{
    [self.theController viewDidLoad];
    XCTAssertTrue([[self.theController.view subviews] containsObject:self.theController.theTableView]);
}

/**
 tc 7.9
 */
- (void)test_TableViewRegisterMyCellAfterViewDidLoad{
    [self.theController viewDidLoad];
    UITableViewCell *cell = [self.theController.theTableView dequeueReusableCellWithIdentifier:[MyCell reuseIdentifier]];
    XCTAssertNotNil(cell);
    XCTAssertTrue([cell isKindOfClass:[MyCell class]]);
}


/**
 tc 7.10
 */
- (void)test_ReloadDataIfFoundTheDataSourceHasDatasAfterViewDidLoad{
    FakeTableView *tableView = [[FakeTableView alloc] init];
    __block NSString *calledMethod;
    tableView.callMethodBlock = ^(NSString *methodName, NSDictionary *parameters) {
        calledMethod = methodName;
    };
    self.theController.theTableView = tableView;
    self.theDataSource.theDataArray = @[@{@"type":@0,@"title":@"Type A Title",@"someId":@"0001"},@{@"type":@1,@"title":@"Type B Title",@"someId":@"0002"}];
    self.theController.theDataSource = self.theDataSource;
    [self.theController viewDidLoad];
    XCTAssertTrue([calledMethod isEqualToString:@"reloadData"]);
}

@end












