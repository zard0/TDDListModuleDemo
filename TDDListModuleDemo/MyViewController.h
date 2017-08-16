//
//  MyViewController.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/10.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDataSourceProtocol.h"

@interface MyViewController : UIViewController

@property (nonatomic, strong) UITableView *theTableView;
@property (nonatomic, strong) id<UITableViewDataSource,UITableViewDelegate,MyDataSourceProtocol> theDataSource;

@end
