//
//  MyModelTests.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/9.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyModel.h"

@interface MyModelTests : XCTestCase

@property (nonatomic, strong) MyModel *model;

@end

@implementation MyModelTests

- (void)setUp {
    [super setUp];
    self.model = [[MyModel alloc] init];
}

- (void)tearDown {
    self.model = nil;
    [super tearDown];
}


/**
  tc 1.1
 */
- (void)testTypeAModelHasAPictureUrl{
    self.model.type = ModelTypeA;
    NSString *picAUrl = @"AUrl";
    XCTAssertTrue([self.model.picUrl isEqualToString:picAUrl]);
}

/**
  tc 1.2
 */
- (void)testTypeBModelHasBPictureUrl{
    self.model.type = ModelTypeB;
    NSString *picBUrl = @"BUrl";
    XCTAssertTrue([self.model.picUrl isEqualToString:picBUrl]);
}

/**
  tc 1.3
 */
- (void)testTypeCModelHasCPictureUrl{
    self.model.type = ModelTypeC;
    NSString *picCUrl = @"CUrl";
    XCTAssertTrue([self.model.picUrl isEqualToString:picCUrl]);
}

- (void)testAPicUrlBPicUrlCPicUrlAreNotEqualToEachOther{
    self.model.type = ModelTypeA;
    NSString *picAUrl = self.model.picUrl;
    self.model.type = ModelTypeB;
    NSString *picBUrl = self.model.picUrl;
    self.model.type = ModelTypeC;
    NSString *picCUrl = self.model.picUrl;
    XCTAssertFalse([picAUrl isEqualToString:picBUrl]);
    XCTAssertFalse([picAUrl isEqualToString:picCUrl]);
    XCTAssertFalse([picBUrl isEqualToString:picCUrl]);
}

- (void)testAPicUrlBPicUrlCPicUrlAreNotEqualToNil{
    self.model.type = ModelTypeA;
    XCTAssertNotNil(self.model.picUrl);
    self.model.type = ModelTypeB;
    XCTAssertNotNil(self.model.picUrl);
    self.model.type = ModelTypeC;
    XCTAssertNotNil(self.model.picUrl);
}


/**
 tc 1.6
 不要用这个测试用例去代替tc 1.1，tc 1.2， tc 1.3
 */
- (void)testTypeATypeBTypeCModelAllHasTheirOwnPicUrl{
    self.model.type = ModelTypeA;
    XCTAssertTrue([self.model.picUrl isEqualToString:@"AUrl"]);
    self.model.type = ModelTypeB;
    XCTAssertTrue([self.model.picUrl isEqualToString:@"BUrl"]);
    self.model.type = ModelTypeC;
    XCTAssertTrue([self.model.picUrl isEqualToString:@"CUrl"]);
}

@end





