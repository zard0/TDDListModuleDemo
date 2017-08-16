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
    // 旧的验证
    //XCTAssertTrue([typeName isEqualToString:@"<UITableViewDataSource><UITableViewDelegate>"]);
    // 新的验证
    XCTAssertTrue([typeName isEqualToString:@"<UITableViewDataSource><UITableViewDelegate><MyDataSourceProtocol>"]);
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

/**
 tc 4.3
 */
- (void)test_reloadTableViewWhenDataSouceGetNewData{
    MyViewController *vc = [[MyViewController alloc] init];
    MyTableViewDataSource *dataSource = [[MyTableViewDataSource alloc] init];
    FakeTableView *tableView = [[FakeTableView alloc] init];
    __block NSString *calledMethod;
    tableView.callMethodBlock = ^(NSString *methodName, NSDictionary *parameters) {
        calledMethod = methodName;
    };
    vc.theTableView = tableView;
    vc.theDataSource = dataSource;
    [vc viewDidLoad];
    dataSource.theDataArray = @[];
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
    MyViewController *myVC = [[MyViewController alloc] init];
    FakeNavigationViewController *nav = [[FakeNavigationViewController alloc] initWithRootViewController:myVC];
    __block NSString *name;
    __block NSDictionary *paras;
    nav.callMethodBlock = ^(NSString *methodName, NSDictionary *parameters) {
        name = methodName;
        paras = parameters;
    };
    MyTableViewDataSource *dataSource = [[MyTableViewDataSource alloc] init];
    UITableView *tableView = [[UITableView alloc] init];
    myVC.theTableView = tableView;
    myVC.theDataSource = dataSource;
    [myVC viewDidLoad];
    myVC.theDataSource.theDataArray = @[@{@"type":@0,@"title":@"Type A Title",@"someId":@"0001"},@{@"type":@1,@"title":@"Type B Title",@"someId":@"0002"}];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [myVC.theDataSource tableView:myVC.theTableView didSelectRowAtIndexPath:indexPath];
    XCTAssertTrue([name isEqualToString:[FakeNavigationViewController pushMethodName]]);
    XCTAssertTrue([paras[[FakeNavigationViewController pushControllerParaKey]] isKindOfClass:[ATypeViewController class]]);
    XCTAssertEqual([paras[[FakeNavigationViewController pushAnimateParaKey]] boolValue] , YES);
}

@end












