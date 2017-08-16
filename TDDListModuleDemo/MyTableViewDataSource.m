//
//  MyTableViewDataSource.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/10.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "MyTableViewDataSource.h"
#import "MyCell.h"

@implementation MyTableViewDataSource

@synthesize theDataArray = _theDataArray;
@synthesize updateBlock;
@synthesize cellTapBlock;

#pragma mark - Properties

- (void)setTheDataArray:(NSArray *)theDataArray{
    _theDataArray = theDataArray;
    if (self.updateBlock) {
        self.updateBlock();
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.theDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyModel *model = [[MyModel alloc] init];
    model.someId = self.theDataArray[indexPath.row][@"someId"];
    model.type = [self.theDataArray[indexPath.row][@"type"] integerValue];
    model.title = self.theDataArray[indexPath.row][@"title"];
    MyCell *cell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:[MyCell reuseIdentifier]];
    NSAssert(cell, @"要将MyCell注册给表格视图对象");
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellTapBlock) {
        self.cellTapBlock(indexPath);
    }
}

@end
