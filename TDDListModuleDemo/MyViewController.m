//
//  MyViewController.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/10.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "MyViewController.h"
#import "ATypeViewController.h"
#import "MyCell.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.theTableView) {
        self.theTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    }
    [self.theTableView registerClass:[MyCell class] forCellReuseIdentifier:[MyCell reuseIdentifier]];
    [self.view addSubview:self.theTableView];
    
    __weak typeof(self) wSelf = self;
    self.theDataSource.updateBlock = ^{
        __strong typeof(self) sSelf = wSelf;
        [sSelf.theTableView reloadData];
    };
    self.theDataSource.cellTapBlock = ^(NSIndexPath *indexPath) {
        __strong typeof(self) sSelf = wSelf;
        NSDictionary *data = sSelf.theDataSource.theDataArray[indexPath.row];
        if ([data[@"type"] integerValue] == 0) {
            ATypeViewController *vc = [[ATypeViewController alloc] init];
            [sSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    self.theTableView.dataSource = self.theDataSource;
    self.theTableView.delegate = self.theDataSource;
    if ([self.theDataSource.theDataArray count] > 0) {
        [self.theTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
